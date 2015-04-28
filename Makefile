CHAPTERS=$(wildcard chapters/*.md)
BEFORE=$(wildcard before/*.md)
IMAGES=$(wildcard images/*)
TEMPLATES=$(wildcard templates/*)
BIBLIOGRAPHY=$(wildcard bib/*)

NAME:=thesis
PANDOC:=pandoc
PANDOC_FLAGS:=-w latex --toc --standalone --biblatex -Vdocumentclass=book -Vfontsize=12pt -Vmainfont="Lora" -Vsansfont="Source Sans Pro" -Vnumbersections -Vgeometry=a4paper,inner=3.5cm,outer=3cm,top=4cm,bottom=4cm
BIBER:=biber
LATEX_ENGINE:=xelatex
LATEX_FLAGS:=-file-line-error -halt-on-error -output-directory build

.PHONY: all clean

all: $(NAME).pdf

clean:
	rm -f build/*

$(NAME).pdf: build/$(NAME).pdf
	cp build/$(NAME).pdf $(NAME).pdf

build/before.tex: $(BEFORE)
	$(PANDOC) -Vdocumentclass=book -o build/before.tex $(BEFORE)

build/$(NAME).pdf: build/$(NAME).tex build/$(NAME).bbl
	$(LATEX_ENGINE) $(LATEX_FLAGS) build/$(NAME).tex

build/$(NAME).tex: build/before.tex $(CHAPTERS) $(IMAGES) $(TEMPLATES)
	$(PANDOC) $(PANDOC_FLAGS) -B build/before.tex -H templates/header.tex --template templates/default.latex --bibliography bib/bibliography.bib $(CHAPTERS) -o build/$(NAME).tex

build/$(NAME).bbl: $(BIBLIOGRAPHY) build/$(NAME).bcf
	$(BIBER) build/$(NAME)

build/$(NAME).bcf: build/$(NAME).tex
	$(LATEX_ENGINE) $(LATEX_FLAGS) build/$(NAME).tex
