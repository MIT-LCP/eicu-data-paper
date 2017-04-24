# eICU Collaborative Research Database

Data descriptor of the eICU Collaborative Research Database for submission to Scientific Data

## Generate the PDF

pandoc "main.md" -o "main.pdf" --bibliography="references.bib" --csl="ref_format.csl" -V fontsize=12pt -V papersize=a4paper -V documentclass:article -N --latex-engine=xelatex 