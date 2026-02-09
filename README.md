# FABulous Tiles

This repository contains the default tile library for FABulous.

The primitives for the tiles can be found in the `primitives/` folder and the tile configuration under `tiles/`. The tiles can be implemented with LibreLane using the FABulous plugin for LibreLane: [librelane_plugin_fabulous](https://github.com/mole99/librelane_plugin_fabulous). See the "Implement the Tiles" section down below for details on how to do so.

Documentation for the primitives and tiles can be found in the respective folder's README. There is also a documentation generated using Sphinx.

A Continuous Integration (CI) setup implements all of the tiles for the gf180mcu, sky130, and ihp-sg13g2 PDKs.

## Requirements

For information on installing Nix with the FOSSi Foundation cache, please refer to the LibreLane documentation: https://librelane.readthedocs.io/en/stable/installation/nix_installation/index.html

## Implement the Tiles

First, enable a Nix shell with LibreLane:

```
nix-shell
```

To implement all tiles, run:

```
make all
```

To implement a single tile, run:

```
make E_IO
```

After a tile has been implemented you can view it either in OpenROAD or KLayout:

```
make E_IO-openroad
make E_IO-klayout
```

By default the tiles are implemented using the ihp-sg13g2 PDK.
The supported PDKs are: `gf180mcu`, `sky130`, `ihp-sg13g2`.

To change the PDK, set the `PDK` environment variable:

```
PDK=gf180mcu make all
```

## Stitch the Tiles

To stitch the tiles into fabrics, please see the following repository: https://github.com/mole99/fabulous-fabrics
