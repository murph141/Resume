# Require software: pdflatex, mupdf, a latex suite
#
# make compile will compile my resume (With a hidden feature)
# make show will compile and display my resume

SHELL=/bin/bash
TEX=Resume.tex
PDF=$(patsubst %.tex,%.pdf,$(TEX))
FILE=$(patsubst %.tex,%,$(TEX))
COMPILE=pdflatex
ZIPFILE=$(FILE).zip
ZIPPER=zip
RESUME=Eric-Resume.pdf

.PHONY: all clean compile help show

help:
	@echo '--------------------------------------------------------------'
	@echo 'clean    -   Removes all the misc files'
	@echo 
	@echo 'compile  -   Compiles my resume with a hidden feature'
	@echo
	@echo 'show	 -   Compiles my resume, and dispalys it using muPDF'
	@echo '--------------------------------------------------------------'

all: $(TEX)
	$(COMPILE) $(TEX) $(PDF)

# This will output a resume that functions as both a PDF and a ZIP file
compile: all
	$(ZIPPER) $(ZIPFILE) $(TEX)
	@cat $(PDF) $(ZIPFILE) > $(RESUME)
	@zip -A $(RESUME)
	@rm -f $(FILE).{aux,log,out,pdf,zip}

show: all
	@rm -f $(FILE).{aux,log,out}
	@mupdf $(PDF)

clean:
	@rm -f $(FILE).{aux,log,out,pdf,zip}
