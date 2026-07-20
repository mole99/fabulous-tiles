IMAGES_ODG := $(wildcard odg/*.odg)

IMAGES_SVG = $(patsubst odg/%.odg,svg/%.svg,$(IMAGES_ODG))

all: $(IMAGES_SVG)

svg/%.svg: odg/%.odg
	soffice --convert-to svg --outdir svg/ $<

clean:
	rm svg/*
