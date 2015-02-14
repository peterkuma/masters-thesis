CHAPTERS=$(wildcard chapters/*.md)
IMAGES=$(wildcard images/*)
TEMPLATES=$(wildcard templates/*)
BIBLIOGRAPHY=$(wildcard bib/*)

NAME:=thesis
PANDOC:=pandoc
PANDOC_FLAGS:=-w latex --toc --standalone --biblatex -Vdocumentclass=book -Vfontsize=12pt -Vmainfont="Lora" -Vsansfont="Source Sans Pro" -Vnumbersections
BIBER:=biber
LATEX_ENGINE:=xelatex
LATEX_FLAGS:=-file-line-error -halt-on-error -output-directory build

.PHONY: all clean

all: $(NAME).pdf

clean:
	rm -f build/*

$(NAME).pdf: build/$(NAME).pdf
	pdftk cover.pdf build/$(NAME).pdf cat output $(NAME).pdf

#build/$(NAME).pdf: build/$(NAME).tex
#	latexmk -e '$$pdflatex=q/xelatex -synctex=1 -interaction=nonstopmode/' -pdf -jobname=build/$(NAME) build/$(NAME).tex

build/$(NAME).pdf: build/$(NAME).tex build/$(NAME).bbl
	$(LATEX_ENGINE) $(LATEX_FLAGS) build/$(NAME).tex

build/$(NAME).tex: $(CHAPTERS) $(IMAGES) $(TEMPLATES)
	$(PANDOC) $(PANDOC_FLAGS) -H templates/header.tex --template templates/default.latex --bibliography bib/bibliography.bib $(CHAPTERS) -o build/$(NAME).tex

build/$(NAME).bbl: $(BIBLIOGRAPHY) build/$(NAME).bcf
	$(BIBER) build/$(NAME)

build/$(NAME).bcf: build/$(NAME).tex
	$(LATEX_ENGINE) $(LATEX_FLAGS) build/$(NAME).tex
