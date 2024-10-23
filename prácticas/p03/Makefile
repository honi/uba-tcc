FILES = $(basename $(notdir $(wildcard src/*.ml)))

OCAMLC = ocamlc -I fuse/src -I +unix -w -A -rectypes -thread unix.cma threads.cma
DECODER = fuse/decoder/rosetta

all: $(FILES)

all_t: $(FILES:%=%.t)

all_st: $(FILES:%=%.st)

%.t: src/%.ml
	@$(OCAMLC) -i $<

%.st: src/%.ml
	@$(OCAMLC) -i $< | $(DECODER)

%: src/%.ml
	@mkdir -p bin
	$(OCAMLC) -o bin/$@ FuSe.cma $<

clean:
	rm -rf src/*.cmo src/*.cmi bin

.PHONY: clean
