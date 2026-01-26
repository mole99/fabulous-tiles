#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Copyright 2024 FABulous Contributors
# SPDX-License-Identifier: Apache-2.0

import os
import shutil
import traceback
from glob import glob

import jinja2
from sphinx.config import Config
from sphinx.application import Sphinx

def setup(app: Sphinx):
    app.connect("config-inited", generate_module_docs)
    return {"version": "1.0"}


def generate_module_docs(app: Sphinx, conf: Config):
    try:
        conf_py_path: str = conf._raw_config["__file__"]
        doc_root_dir: str = os.path.dirname(conf_py_path)

        template_relpath: str = conf.templates_path[0]
        template_path = os.path.abspath(os.path.join(doc_root_dir, template_relpath))
        
        lookup = jinja2.FileSystemLoader(searchpath=template_path)

        # Mako-like environment
        env = jinja2.Environment(
            "<%",
            "%>",
            "${",
            "}",
            "<%doc>",
            "</%doc>",
            "%",
            "##",
            loader=lookup,
        )
        
        # Primitives
        
        primitives = []
        
        for filename in glob(os.path.abspath(os.path.join(doc_root_dir, "../../primitives/**/README.md")), recursive=True):
            with open(filename, "r") as fi:
                primitive_content = ""
                # Decrease headings by one level
                for line in fi.readlines():
                    if line.startswith("#"):
                        line = "#" + line
                    primitive_content += line
            
            primitive_name = os.path.basename(os.path.dirname(filename))
            primitives.append((primitive_name, primitive_content))

        print("0000000000000000000")
        image_path = os.path.abspath(os.path.join(doc_root_dir, "primitives", "images", "svg"))
        for filename in glob(os.path.abspath(os.path.join(doc_root_dir, "../../primitives/**/images/svg/*.svg")), recursive=True):
            image_name = os.path.basename(filename)
            dest = os.path.join(image_path, image_name)
            shutil.copyfile(filename, dest)
            
        

        template = env.get_template("all_primitives.md")
        with open(
            os.path.join(doc_root_dir, "primitives", "all_primitives.md"), "w"
        ) as f:
            f.write(
                template.render(
                    primitives=primitives,
                )
            )

        # Tiles
        
        tiles = []
        
        for filename in glob(os.path.abspath(os.path.join(doc_root_dir, "../../tiles/**/README.md")), recursive=True):
            with open(filename, "r") as fi:
                tile_content = ""
                # Decrease headings by one level
                for line in fi.readlines():
                    if line.startswith("#"):
                        line = "#" + line
                    tile_content += line + "\n"
            
            tile_name = os.path.basename(os.path.dirname(filename))
            tiles.append((tile_name, tile_content))

        template = env.get_template("all_tiles.md")
        with open(
            os.path.join(doc_root_dir, "tiles", "all_tiles.md"), "w"
        ) as f:
            f.write(
                template.render(
                    tiles=tiles,
                )
            )

    except Exception:
        print(traceback.format_exc())
        exit(-1)
