LATEX := pdflatex
LATEXFLAGS := -interaction=nonstopmode --shell-escape -synctex=1

*.pdf: *.tex
	$(LATEX) $(LATEXFLAGS) --jobname $(basename $<) $<
	$(LATEX) $(LATEXFLAGS) --jobname $(basename $<) $<

watch:
	while inotifywait -e close_write *.tex; do make; done

clean:
	rm -rf *.aux *.log *.nav *.out *.snm *.synctex.gz *.toc ./tmp

.PHONY: watch clean
