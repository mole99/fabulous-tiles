# Configuration file for the Sphinx documentation builder.
#
# For the full list of built-in configuration values, see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

import sys
import os

# -- Path setup --------------------------------------------------------------

# Custom extensions
sys.path.insert(0, os.path.abspath("_ext"))

# -- Project information -----------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#project-information

project = 'FABulous Tile Library'
copyright = '2026, FABulous Contributors'
author = 'FABulous Contributors'
release = '1.0.0'
version = release

# -- General configuration ---------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#general-configuration

custom_extensions = [
    'generate_docs',
]
third_party_extensions = [
    'myst_parser',
    'sphinxcontrib.inkscapeconverter'
]
extensions = third_party_extensions + custom_extensions

source_suffix = {
    '.md': 'markdown',
    '.rst': 'restructuredtext',
}

root_doc = "index"

templates_path = ['_templates']
exclude_patterns = []

# -- Options for HTML output -------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#options-for-html-output

html_title = 'FABulous Tile Library'
html_theme = 'furo'
html_static_path = ['_static']

# Auto-generated header anchors.
# https://myst-parser.readthedocs.io/en/stable/syntax/optional.html#syntax-header-anchors
myst_heading_anchors = 2

myst_enable_extensions = [
    "attrs_inline",
]

