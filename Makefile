TFILES = $(wildcard *.typ)
PFILES = $(patsubst %.typ,%.pdf,$(TFILES))
HFILES = $(patsubst %.typ,%.html,$(TFILES))
INDEX_JSON_FILE_PATH=index.json

all: index pdf html

index: $(TFILES)
	./index.sh $<

pdf: $(PFILES)

html: $(HFILES)

%.pdf: %.typ
	typst compile $< $@

%.html: %.typ
	typst compile --features html $< $@

clean:
	rm -f $(PFILES)
	rm -f $(HFILES)
	rm -f $(INDEX_JSON_FILE_PATH)
