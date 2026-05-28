TFILES = $(wildcard *.typ)
PFILES = $(patsubst %.typ,%.pdf,$(TFILES))
HFILES = $(patsubst %.typ,%.html,$(TFILES))

all: pdf html

pdf: $(PFILES)

html: $(HFILES)

%.pdf: %.typ
	typst compile $< $@

%.html: %.typ
	typst compile --features html $< $@

clean:
	rm -f $(PFILES)
	rm -f $(HFILES)
