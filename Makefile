PDK ?= ihp-sg13g2
TILE_LIBRARY ?= classic

# Get the tile names
TILES :=  $(patsubst tiles/${TILE_LIBRARY}/%,%,$(wildcard tiles/${TILE_LIBRARY}/*)) 
TILES := $(filter-out common,$(TILES))

TILES_OPENROAD := $(addsuffix -openroad,$(TILES))
TILES_KLAYOUT := $(addsuffix -klayout,$(TILES))
TILES_CLEAN := $(addsuffix -clean,$(TILES))

all: $(TILES)
.PHONY: all

clean: $(TILES_CLEAN)
.PHONY: clean

$(TILES):
	#librelane --pdk ${PDK} tiles/common/common.yaml tiles/$@/config.yaml
	PDK=${PDK} TILE_LIBRARY=${TILE_LIBRARY} python3 tiles.py $@
.PHONY: $(TILES)

$(TILES_OPENROAD):
	#librelane --pdk ${PDK} tiles/common/common.yaml tiles/$(subst -openroad,,$@)/config.yaml --last-run --flow OpenInOpenROAD
	PDK=${PDK} TILE_LIBRARY=${TILE_LIBRARY} python3 tiles.py $(subst -openroad,,$@) --gui openroad
.PHONY: $(TILES_OPENROAD)

$(TILES_KLAYOUT):
	#librelane --pdk ${PDK} tiles/common/common.yaml tiles/$(subst -klayout,,$@)/config.yaml --last-run --flow OpenInKLayout
	PDK=${PDK} TILE_LIBRARY=${TILE_LIBRARY} python3 tiles.py $(subst -klayout,,$@) --gui klayout
.PHONY: $(TILES_KLAYOUT)

$(TILES_CLEAN):
	rm -rf tiles/${TILE_LIBRARY}/$(subst -clean,,$@)/$(subst -clean,,$@).v
	rm -rf tiles/${TILE_LIBRARY}/$(subst -clean,,$@)/$(subst -clean,,$@)_ConfigMem.csv
	rm -rf tiles/${TILE_LIBRARY}/$(subst -clean,,$@)/$(subst -clean,,$@)_ConfigMem.v
	rm -rf tiles/${TILE_LIBRARY}/$(subst -clean,,$@)/$(subst -clean,,$@)_switch_matrix.csv
	rm -rf tiles/${TILE_LIBRARY}/$(subst -clean,,$@)/$(subst -clean,,$@)_switch_matrix.v
.PHONY: $(TILES_CLEAN)
