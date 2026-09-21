MAKEFILE_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

PDK ?= ihp-sg13g2
TILE_LIBRARY ?= classic

# Get the tile names
TILES :=  $(patsubst tiles/${TILE_LIBRARY}/%/,%,$(wildcard tiles/${TILE_LIBRARY}/*/))
TILES := $(filter-out common,$(TILES))

ifeq ($(filter $(PDK),ihp-sg13g2 ihp-sg13cmos5l),)
TILES := $(filter-out E_IHP_SRAM,$(TILES))
TILES := $(filter-out E_IHP_BRAM,$(TILES))
endif

ifeq ($(SCL),gf180mcu_as_sc_mcu7t3v3)
TILES := $(filter-out MACC,$(TILES))
TILES := $(filter-out S_term_MACC,$(TILES))
TILES := $(filter-out N_term_MACC,$(TILES))
TILES := $(filter-out E_TT_IF2,$(TILES))
TILES := $(filter-out E_TT_IF,$(TILES))
TILES := $(filter-out E_TT_IF_MUX,$(TILES))
TILES := $(filter-out W_TT_IF2,$(TILES))
TILES := $(filter-out W_TT_IF,$(TILES))
TILES := $(filter-out W_TT_IF_MUX,$(TILES))
endif

ifeq ($(PDK),icsprout55)
TILES := LUT4x8_ha N_IO E_IO S_IO W_IO SW_term SE_term NW_term NE_term
endif

ifeq ($(PDK),icsprout55)
PDK_ROOT ?= $(MAKEFILE_DIR)/icsprout55-openpdk
PDK ?= icsprout55
PDK_REPO ?= https://github.com/ckdur/icsprout55-openpdk
PDK_COMMIT ?= 9567646e86e660d3a8c9e1bd535aadf614937de9
endif

clone-icsprout55:
	mkdir -p $(PDK_ROOT)
	git clone $(PDK_REPO) --recurse-submodules --depth=1 --revision $(PDK_COMMIT) $(PDK_ROOT)
	cd $(PDK_ROOT); bash ./install.sh
.PHONY: clone-icsprout55

$(info Available tiles for tile library $(TILE_LIBRARY): $(TILES))

TILES_OPENROAD := $(addsuffix -openroad,$(TILES))
TILES_KLAYOUT := $(addsuffix -klayout,$(TILES))
TILES_CLEAN := $(addsuffix -clean,$(TILES))

all: $(TILES)
.PHONY: all

clean: $(TILES_CLEAN)
.PHONY: clean

$(TILES):
	PDK_ROOT=${PDK_ROOT} PDK=${PDK} TILE_LIBRARY=${TILE_LIBRARY} SCL=${SCL} python3 tiles.py $@
.PHONY: $(TILES)

$(TILES_OPENROAD):
	PDK_ROOT=${PDK_ROOT} PDK=${PDK} TILE_LIBRARY=${TILE_LIBRARY} SCL=${SCL} python3 tiles.py $(subst -openroad,,$@) --gui openroad
.PHONY: $(TILES_OPENROAD)

$(TILES_KLAYOUT):
	PDK_ROOT=${PDK_ROOT} PDK=${PDK} TILE_LIBRARY=${TILE_LIBRARY} SCL=${SCL} python3 tiles.py $(subst -klayout,,$@) --gui klayout
.PHONY: $(TILES_KLAYOUT)

$(TILES_CLEAN):
	# Normal tiles
	rm -rf tiles/${TILE_LIBRARY}/$(subst -clean,,$@)/$(subst -clean,,$@).v
	rm -rf tiles/${TILE_LIBRARY}/$(subst -clean,,$@)/$(subst -clean,,$@)_ConfigMem.csv
	rm -rf tiles/${TILE_LIBRARY}/$(subst -clean,,$@)/$(subst -clean,,$@)_ConfigMem.v
	rm -rf tiles/${TILE_LIBRARY}/$(subst -clean,,$@)/$(subst -clean,,$@)_switch_matrix.csv
	rm -rf tiles/${TILE_LIBRARY}/$(subst -clean,,$@)/$(subst -clean,,$@)_switch_matrix.v
	# Supertiles
	rm -rf tiles/${TILE_LIBRARY}/$(subst -clean,,$@)/*/$(subst -clean,,$@)_*.v
	rm -rf tiles/${TILE_LIBRARY}/$(subst -clean,,$@)/*/$(subst -clean,,$@)_*_ConfigMem.csv
	rm -rf tiles/${TILE_LIBRARY}/$(subst -clean,,$@)/*/$(subst -clean,,$@)_*_ConfigMem.v
	rm -rf tiles/${TILE_LIBRARY}/$(subst -clean,,$@)/*/$(subst -clean,,$@)_*_switch_matrix.csv
	rm -rf tiles/${TILE_LIBRARY}/$(subst -clean,,$@)/*/$(subst -clean,,$@)_*_switch_matrix.v
.PHONY: $(TILES_CLEAN)

######################

PRIMITIVES :=  $(patsubst primitives/%/,%,$(wildcard primitives/*/))
PRIMITIVES := $(filter-out common,$(PRIMITIVES))

TILES_SVG := $(addsuffix -svg,$(PRIMITIVES))

$(TILES_SVG):
	cd primitives/$(subst -svg,,$@)/images && make all
.PHONY: $(TILES_SVG)

all-images: $(TILES_SVG)
.PHONY: all-images
