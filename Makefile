MAKEFILE_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

PDK ?= ihp-sg13g2

# Get the tile names
TILES :=  $(patsubst tiles/%,%,$(wildcard tiles/*)) 
TILES := $(filter-out common,$(TILES))
TILES := $(filter-out 8xLUT4_C,$(TILES))

TILES_OPENROAD := $(addsuffix -openroad,$(TILES))
TILES_KLAYOUT := $(addsuffix -klayout,$(TILES))

all: $(TILES)
.PHONY: all

$(TILES):
	librelane --pdk ${PDK} tiles/common/common.yaml tiles/$@/config.yaml
.PHONY: $(TILES)

$(TILES_OPENROAD):
	librelane --pdk ${PDK} tiles/common/common.yaml tiles/$(subst -openroad,,$@)/config.yaml --last-run --flow OpenInOpenROAD
.PHONY: $(TILE_PATHS_OPENROAD)

$(TILES_KLAYOUT):
	librelane --pdk ${PDK} tiles/common/common.yaml tiles/$(subst -klayout,,$@)/config.yaml --last-run --flow OpenInKLayout
.PHONY: $(TILE_PATHS_KLAYOUT)
