#!/usr/bin/env python3
# Copyright 2025 FABulous Contributors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
import os
import sys
import yaml
import fnmatch
import argparse

from librelane.flows import Flow, FlowError
from librelane.common import get_pdk_hash
from librelane.logging import (
    verbose,
    debug,
    info,
    rule,
    success,
    warn,
    err,
    subprocess,
)

__dir__ = os.path.dirname(os.path.realpath(__file__))


# Define the tile sizes
# The order of the patterns is important:
# the first pattern that matches will be used
tile_sizes = {
    "sky130*": {
        # High density cells
        # Width should be multiple of 0.46 (met2 pitch)
        # Height should be multiple of 0.68 (met3 pitch)
        # Standard cell row height: 2.72 (4 met3 track)
    
        "LUT4x8_ha" : (210.80, 223.04),

        "RegFile"       : (210.80+0.46*90, 223.04),
        "S_term_RegFile": (210.80+0.46*90,  57.12),
        "N_term_RegFile": (210.80+0.46*90,  57.12),

        "MACC"          : (210.80, 223.04*2),
        "S_term_MACC"   : (210.80,  57.12),
        "N_term_MACC"   : (210.80,  57.12),

        "NE*"       : ( 56.12,  57.12),
        "NW*"       : ( 56.12,  57.12),
        "SE*"       : ( 56.12,  57.12),
        "SW*"       : ( 56.12,  57.12),
        
        "N*"        : (210.80,  57.12),
        "E*"        : ( 56.12, 223.04),
        "S*"        : (210.80,  57.12),
        "W*"        : ( 56.12, 223.04),
    },
    "gf180mcu*": {
        # Width should be multiple of 0.56 (Metal2 pitch)
        # Height should be multiple of 0.56 (Metal3 pitch)
        # Standard cell row height: 3.92 (8 Metal3 track)
        # TODO: there seem to be delay buffers in the
        # framedata signals due to the SDC constraints

        "LUT4x8_ha" : (302.96, 302.96),

        "RegFile"       : (302.96+0.56*90, 302.96),
        "S_term_RegFile": (302.96+0.56*90,  77.84),
        "N_term_RegFile": (302.96+0.56*90,  77.84),

        "MACC"          : (302.96, 302.96*2),
        "S_term_MACC"   : (302.96,  77.84),
        "N_term_MACC"   : (302.96,  77.84),

        "NE*"       : ( 72.80,  77.84),
        "NW*"       : ( 72.80,  77.84),
        "SE*"       : ( 72.80,  77.84),
        "SW*"       : ( 72.80,  77.84),
        
        "N*"        : (302.96,  77.84),
        "E*"        : ( 72.80, 302.96),
        "S*"        : (302.96,  77.84),
        "W*"        : ( 72.80, 302.96),
    },
    "ihp-sg13*": {
        # Width should be multiple of 0.48 (Metal2 pitch)
        # Height should be multiple of 0.42 (Metal3 pitch)
        # Standard cell row height: 3.78 (9 Metal3 tracks)

        "LUT4x8_ha"     : (219.84, 219.24),

        "RegFile"       : (219.84+0.48*90, 219.24),
        "S_term_RegFile": (219.84+0.48*90,  56.70),
        "N_term_RegFile": (219.84+0.48*90,  56.70),

        "MACC"          : (219.84, 219.24*2),
        "S_term_MACC"   : (219.84,  56.70),
        "N_term_MACC"   : (219.84,  56.70),

        "NE*"       : ( 68.64,  56.70),
        "NW*"       : ( 68.64,  56.70),
        "SE*"       : ( 68.64,  56.70),
        "SW*"       : ( 68.64,  56.70),
        
        "N*"        : (219.84,  56.70),
        "E*"        : ( 68.64, 219.24),
        "S*"        : (219.84,  56.70),
        "W*"        : ( 68.64, 219.24),
    },
}

tile_densities = {
    "sky130*": {
        "LUT4x8_ha" : 58,
        "*"         : None,
    },
    "gf180mcu*": {
        "LUT4x8_ha" : 85,
        "*"         : None,
    },
    "ihp-sg13*": {
        "LUT4x8_ha" : 96,
        "*"         : None,
    },
}


def main(tile, pdk_root=None, pdk=None, tag=None, last_run=None, gui=None):
    target_flow = Flow.factory.get("FABulousTile")

    # Don't throw exception on hold violations
    #target_flow.Steps.remove(Checker.HoldViolations)

    if gui == "openroad":
        target_flow = Flow.factory.get("OpenInOpenROAD")

    if gui == "klayout":
        target_flow = Flow.factory.get("OpenInKLayout")

    common_config_path = os.path.join(__dir__, "tiles", "common", "common.yaml")
    tile_config_path = os.path.join(__dir__, "tiles", tile, "config.yaml")

    if not os.path.isfile(common_config_path):
        raise FlowError(f"Error: Couldn't find common config: {common_config_path}") from None

    if not os.path.isfile(tile_config_path):
        raise FlowError(f"Error: Couldn't find tile config: {tile_config_path}") from None

    # Run the flow
    config = yaml.safe_load(open(common_config_path))
    tile_config = yaml.safe_load(open(tile_config_path))
    config.update(tile_config)
    
    # Get the tile area
    tile_size = None
    for pdk_pattern, tile_values in tile_sizes.items():
        if fnmatch.fnmatch(pdk, pdk_pattern):
            print(f"Matched pdk {pdk} with {pdk_pattern}")
            
            for tile_pattern, size in tile_values.items():
                if fnmatch.fnmatch(tile, tile_pattern):
                    print(f"Matched tile {tile} with {tile_pattern}")
                    tile_size = size
    
    if not tile_size:
        raise FlowError(f"Couldn't match a tile size for {tile} with {pdk}") from None

    # Get the target density
    target_density = None
    for pdk_pattern, tile_values in tile_densities.items():
        if fnmatch.fnmatch(pdk, pdk_pattern):
            print(f"Matched pdk {pdk} with {pdk_pattern}")
            
            for tile_pattern, density in tile_values.items():
                if fnmatch.fnmatch(tile, tile_pattern):
                    print(f"Matched tile {tile} with {tile_pattern}")
                    target_density = density


    print(f"Tile size: {tile_size}")
    print(f"Tile target density: {target_density}")
    
    config["DIE_AREA"] = [0, 0, tile_size[0], tile_size[1]]
    
    if target_density:
        config["PL_TARGET_DENSITY_PCT"] = target_density

    print(config)

    design_dir = os.path.join(__dir__, "tiles", tile)

    print(design_dir)

    # Fetch the PDK using ciel
    if pdk_root is None:
        import ciel
        from ciel.source import StaticWebDataSource

        opdks_rev = get_pdk_hash(pdk)
        ciel_home = ciel.get_ciel_home(pdk_root)
        
        pdk_family = None
        if family := ciel.Family.by_name.get(pdk):
            pdk = family.default_variant
            pdk_family = family.name
            verbose(f"Resolved PDK variant {family.default_variant}.")
        else:
            for family in ciel.Family.by_name.values():
                if pdk in family.variants:
                    pdk_family = family.name
                    break

        if pdk_family is None:
            err(f"Could not resolve the PDK '{pdk}'.")
            exit(1)
        
        include_libraries = ["default"]
        version = ciel.fetch(
            ciel_home,
            pdk_family,
            opdks_rev,
            data_source=StaticWebDataSource(
                "https://fossi-foundation.github.io/ciel-releases"
            ),
            include_libraries=include_libraries,
        )
        pdk_root = version.get_dir(ciel_home)
    
    
    flow = target_flow(
        config,
        design_dir=design_dir,
        pdk_root=pdk_root,
        pdk=pdk,
    )
    
    state_out = flow.start(tag=tag, last_run=last_run)

    print("Done!")

if __name__ == "__main__":

    parser = argparse.ArgumentParser(
                description="This script uses the 'FABulousTile' flow to implement tiles.",
                epilog="Copyright © 2026, FABulous Contributors")

    parser.add_argument("tilename")
    parser.add_argument('--gui', choices=["openroad", "klayout"])
    
    args = parser.parse_args()
    
    pdk = os.getenv("PDK")
    pdk_root = os.getenv("PDK_ROOT")
    
    if pdk is None:
        raise FlowError(f"Please define PDK") from None
    
    last_run = False
    if args.gui:
        last_run = True

    # Implement the tile
    main(args.tilename, gui=args.gui, pdk=pdk, pdk_root=pdk_root, last_run=last_run)
