BASEDIR=$(CURDIR)
INPUTDIR=$(BASEDIR)/source
OUTPUTDIR=$(BASEDIR)/output
TEMPLATEDIR=$(INPUTDIR)/templates
STYLEDIR=$(BASEDIR)/style
BIBFILE=$(BASEDIR)/references.bib

help:
	@echo ' 																	  '
	@echo 'Makefile for the article                                               '
	@echo '                                                                       '
	@echo 'Usage:                                                                 '
	@echo '   make pdf                         generate a PDF file  			  '
	@echo '   make docx	                       generate a Docx file 			  '
	@echo '   make tex	                       generate a Latex file 			  '
	@echo '                                                                       '
	@echo ' 																	  '
	@echo ' 																	  '
	@echo 'get local templates with: pandoc -D latex/html/etc	  				  '
	@echo 'or generic ones from: https://github.com/jgm/pandoc-templates		  '

pdf:
	pandoc main.md \
	-o main.pdf \
	--bibliography="$(BIBFILE)" 2>pandoc.log \
	--csl=ref_format.csl \
	--highlight-style pygments \
	-V fontsize=12pt \
	-V papersize=a4paper \
	-V documentclass:article \
	-N \
	--latex-engine=xelatex 

tex:
	pandoc main.md \
	-o main.tex \
	--bibliography="$(BIBFILE)" \
	-V fontsize=12pt \
	-V papersize=a4paper \
	-V documentclass:article \
	-N \
	--csl=ref_format.csl \
	--latex-engine=xelatex

docx:
	pandoc main.md \
	-o main.docx \
	--bibliography="$(BIBFILE)" \
	--csl=ref_format.csl \
	--toc

.PHONY: help pdf docx html tex