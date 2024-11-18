LATEX := lualatex
LATEXFLAGS := -interaction=nonstopmode --shell-escape -synctex=1

*.pdf: *.tex
	$(LATEX) $(LATEXFLAGS) --jobname $(basename $<) $<

clean:
	rm *.aux *.log *.nav *.out *.snm *.synctex.gz *.toc

.PHONY: clean
