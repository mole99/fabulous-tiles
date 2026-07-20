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

ifeq ($(PDK),ihp-sg13cmos5l)
PDK_ROOT ?= $(MAKEFILE_DIR)/IHP-Open-PDK
PDK ?= ihp-sg13cmos5l

PDK_REPO_IHP ?= https://github.com/IHP-GmbH/IHP-Open-PDK
PDK_COMMIT_IHP ?= 22f2a25f1734796de3debbbf29cf697cbbc54081

PDK_REPO ?= https://github.com/IHP-GmbH/ihp-sg13cmos5l
PDK_COMMIT ?= e8a87d708b8977e7c07684b033658a0f80af59a0
endif

clone-ihp-sg13cmos5l:
	#ciel enable $(PDK_COMMIT) --pdk-root $(PDK_ROOT) --pdk-family $(PDK)
	mkdir -p $(PDK_ROOT)
	#git clone $(PDK_REPO) --recurse-submodules --depth=1 --single-branch -b $(PDK_BRANCH) $(PDK_ROOT)
	git clone $(PDK_REPO_IHP) --recurse-submodules --depth=1 --revision $(PDK_COMMIT_IHP) $(PDK_ROOT)
	git clone $(PDK_REPO) --recurse-submodules --depth=1 --revision $(PDK_COMMIT) $(PDK_ROOT)/$(PDK)
.PHONY: clone-ihp-sg13cmos5l

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
