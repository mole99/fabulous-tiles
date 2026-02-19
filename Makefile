PDK ?= ihp-sg13g2

# Get the tile names
TILES :=  $(patsubst tiles/%,%,$(wildcard tiles/*)) 
TILES := $(filter-out common,$(TILES))

TILES_OPENROAD := $(addsuffix -openroad,$(TILES))
TILES_KLAYOUT := $(addsuffix -klayout,$(TILES))

all: $(TILES)
.PHONY: all

$(TILES):
	#librelane --pdk ${PDK} tiles/common/common.yaml tiles/$@/config.yaml
	PDK=${PDK} python3 implement.py $@
.PHONY: $(TILES)

$(TILES_OPENROAD):
	#librelane --pdk ${PDK} tiles/common/common.yaml tiles/$(subst -openroad,,$@)/config.yaml --last-run --flow OpenInOpenROAD
	PDK=${PDK} python3 implement.py $(subst -openroad,,$@) --gui openroad
.PHONY: $(TILES_OPENROAD)

$(TILES_KLAYOUT):
	#librelane --pdk ${PDK} tiles/common/common.yaml tiles/$(subst -klayout,,$@)/config.yaml --last-run --flow OpenInKLayout
	PDK=${PDK} python3 implement.py $(subst -klayout,,$@) --gui klayout
.PHONY: $(TILES_KLAYOUT)
