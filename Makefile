
# Generischer GNU Makefile für die Formatierung von Markdown-Dokumenten mit
# Pandoc. Eingabedokumente sind alle .md-Dateien in diesem Verzeichnis, für
# jede Markdown-Datei wird ein eigenes Ausgabedokument erzeugt.

# An Software wird benötigt:

# - pandoc, pandoc-citeproc (http://pandoc.org/)
# - pandoc-crossref (https://github.com/lierdakil/pandoc-crossref)
# - LaTeX für die PDF-Ausgabe (vgl. http://pandoc.org/installing.html)
# - GNU make zum automatisierten Konvertieren (http://www.mingw.org/)

# Mediendateien: Das Makefile verwendet außerdem youtube-dl
# (https://rg3.github.io/youtube-dl/) zum Herunterladen der Videobeispiele.
# Zum Formatieren der Notenbeispiele wird Lilypond benötigt
# (http://lilypond.org/), Ghostscript (http://www.ghostscript.com/) und
# ImageMagick (http://www.imagemagick.org/).

# Fonts: Das Beispieldokument verwendet Minion Pro (beim Acrobat Reader dabei)
# und den TeX-Font mathpazo (bei TeXLive dabei). Falls Minion Pro nicht
# vorhanden ist, kann man einfach die entsprechende Zeile im YAML-Header von
# Test.md löschen.

# Arch-Pakete: pandoc, pandoc-citeproc, pandoc-crossref, make, texlive (-bin,
# -core, -fontsextra, -latexextra), youtube-dl, lilypond, ghostscript,
# imagemagick; AUR: ttf-adobe-fonts

# Benutzung:

# make: generiert pdf-Dokument
# make html: generiert html-Dokument
# make epub: generiert E-Buch
# make beamer: generiert pdf-Folien mit Beamer
# make dzslides: generiert html-Folien mit dzslides
# make revealjs: generiert html-Folien mit reveal.js
# make world: generiere alle Formate (html, pdf, beamer, revealjs, epub)
# make zip: generiere ZIP-Datei
# make media: generiert alle benötigten Mediendateien (Lilypond-Partituren)
# bzw. lädt diese herunter (YouTube-Videos)

# Um einzelne Dokumente in bestimmten Ausgabeformaten zu erzeugen, gibt man
# explizit die Markdown-Quelldokumente mit der docs-Variablen an, z.B.:
# make docs=Foo.md, make html docs=Foo.md, usw.

# Aufräumen:

# make clean: löscht alle erzeugten Dokumente außer den Lilypond-Partituren
# make realclean: löscht alle erzeugten Dokumente inkl. den Lilypond-Partituren

# VORSICHT: make realclean löscht u.U. Grafikdateien, die spezielle Tools
# (Lilypond, Ghostscript, ImageMagick) benötigen, um neu erstellt zu werden!

# Projektname, wird zur Generierung der ZIP-Datei verwendet.
name = Pandoc-Vorlage

# Template-Variablen, vgl. http://pandoc.org/README.html#templates. Man
# beachte, dass die meisten dieser Einstellungen auch im YAML-Header des
# Dokuments stehen können. Falls sie über Kommandozeilenoptionen angegeben
# werden, werden die im YAML-Header gewählten Optionen überschrieben.

# LaTeX-Font setzen
# LaTeX Font-Paket
#font += -V "fontfamily:mathpazo"
#font += -V "fontfamily:eulervm"
#font += -V "fontfamilyoptions:osf,sc"
# System-Fonts
#font += -V "mainfont:Arial"
#font += -V "mainfont:Palatino"
#font += -V "mainfont:Palatino Linotype"
#font += -V "mainfont:Minion Pro"
#font += -V "mainfontoptions:Numbers=OldStyle"
#font += -V "monofont:Bitstream Vera Sans Mono"
#font += -V "monofontoptions:Scale=0.8"

# Fontgröße (pt)
#font += -V fontsize:12pt

# Sprache:
#lang = -V lang:de

# Papierformat:
#geom = -V papersize:A4 -V geometry:top=2cm,bottom=2cm,left=2cm,right=3cm

# Bibliographie(n), die für Literaturverweise verwendet werden sollen
#bib = bibliography.bib

# Zitierstil (CSL-Datei), kann auch im YAML-Header des Dokuments gesetzt werden
#csl=styles/csl/chicago-note-bibliography.csl

# Filter-Optionen für Quer- und Literaturverweise, benötigt pandoc-crossref
# und pandoc-citeproc. Diese lassen sich hier einzeln auskommentieren, falls
# sie nicht benötigt werden. Sprachanpassungen für pandoc-crossref werden mit
# -M crossrefYaml vorgenommen, Bibliographien können mit --bibliography
# angegeben werden (alternativ auch direkt im YAML-Header des Dokuments).
filter += -F pandoc-crossref -M crossrefYaml=styles/pandoc-crossref-de.yaml
filter += -F pandoc-citeproc $(addprefix --bibliography==,$(bib))
ifdef csl
filter += -M csl=$(csl)
endif

# HTML-Folien-Formate und Vorlagen
ifeq ($(slides), dzslides)
slideformat = -t dzslides --template=styles/templates/default.dzslides
endif
ifeq ($(slides), revealjs)
# reveal.js: https://github.com/hakimel/reveal.js; nützliche Variablen:
# theme, transition; nützliche Tasturkürzel: ESC - Folienübersicht,
# Kursortasten, SPC - nächste Folie, Alt-Click: Vergrößern
# weitere Infos unter http://lab.hakim.se/reveal-js/#/
slideformat = -t revealjs --template=styles/templates/default.revealjs -V revealjs-url=styles/reveal.js
# reveal.js-Thema wie gewünscht anpassen
slideformat += -V theme=white -V transition=convex
endif
ifeq ($(slides), beamer)
slideformat = -t beamer
# beamer-Thema wie gewünscht anpassen
#slideformat += -V theme=Warsaw
endif

# CSS style sheet für HTML (außer Folien)
css = -c styles/css/buttondown.css
# CSS style sheet für EPUB
epub-css = --epub-stylesheet=styles/css/epub.css

# numbered-Option (damit Abschnitte automatisch nummeriert werden)
numbered = -N

# incremental-Option (Aufzählungspunkte auf Folien werden nacheinander angezeigt)
#incremental = -i

# HTML-Unterstützung für mathematische Formeln, benötigt MathML oder MathJax.
# MathJax ist mit den meisten Browsern kompatibel und bietet die bessere
# Ausgabequalität, ist aber langsam und benötigt externe Javascript-Module.
# MathML andererseits ist derzeit nur mit Firefox und Safari kompatibel. (Für
# EPUB erzwingen wir generell MathML, da MathJax dort nicht unterstützt wird.)

# MathML (Default)
#math = --mathml

# MathJax online -- benötigt funktionierende Internetverbindung!
math = --mathjax="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"

# lokale MathJax-Installation -- umfangreiches Paket! Dazu muss man MathJax
# von https://github.com/mathjax/MathJax/releases herunterladen und ins
# richtige Verzeichnis kopieren bzw. den Dateinamen anpassen.
#math = --mathjax="styles/MathJax/MathJax.js?config=TeX-AMS-MML_HTMLorMML"

# PDF-Optionen (XeTeX wird benötigt, um Unicode-Zeichen korrekt darzustellen)
pdfoptions = --latex-engine=xelatex
# Farbe in Syntax-Highlighting abschalten
#pdfoptions += --highlight-style=monochrome
# oben gewählte Optionen für Papierformat, Font, Sprache usw. hinzufügen
pdfoptions += $(geom) $(font) $(lang)

# LaTeX-Präamble-Anpassungen für Folien und normale Texte
ifeq ($(slides), beamer)
pdfoptions += -H styles/tex/beamer-custom.tex
# Option: Beamer Fontgröße
pdfoptions += -V fontsize=10pt
# Option: Beamer Navigationsleiste
pdfoptions += -V navigation=horizontal
else
pdfoptions += -H styles/tex/latex-custom.tex
endif

# HTML-Optionen.
htmloptions = $(font) $(lang)
# Optionen für Standalone-Dokumente und Smart Quotes.
htmloptions += -s -S

# Eingabe- und Ausgabe-Dokumente
docs = $(wildcard *.md)
htmls = $(docs:.md=.html)
epubs = $(docs:.md=.epub)
pdfs = $(docs:.md=.pdf)

# Namenszusatz für Folien (Ausgabe-Dokumente)
slide-suffix=-slides
html-slides = $(htmls:%.html=%$(slide-suffix).html)
pdf-slides = $(pdfs:%.pdf=%$(slide-suffix).pdf)

# Default-Styles (CSS für plain HTML)
css-styles = $(wildcard styles/css/*.css)

# Lilypond-Partituren zur automatischen Konvertierung
ly = $(wildcard *.ly)
media = $(ly:.ly=.pdf) $(ly:.ly=.png)

# Videos zum Einbetten (YouTube-Download; benötigt youtube-dl)
media += future.mp4

.PHONY: all world beamer dzslides revealjs html epub pdf media clean realclean zip

# 'make': baut normales PDF-Dokument
all: pdf

# 'make world': alles (PDF-Dokument, HTML, E-Buch, Folien im PDF- und HTML-Format)
world: pdf html epub beamer revealjs

beamer:
	$(MAKE) slides=beamer pdf-slides
dzslides:
	$(MAKE) slides=dzslides html-slides
revealjs:
	$(MAKE) slides=revealjs html-slides

html: $(htmls)
epub: $(epubs)
pdf: $(pdfs)
media: $(media)

html$(slide-suffix): $(html-slides)
pdf$(slide-suffix): $(pdf-slides)

# Folien-Ausgabe
%$(slide-suffix).html: %.md Makefile $(media)
	pandoc $(filter) $< $(slideformat) -o $@ $(incremental) $(htmloptions) $(math)

%$(slide-suffix).epub: %.md Makefile $(css-styles) $(media)
	pandoc $(filter) $< -o $@ $(htmloptions) $(epub-css) --mathml

%$(slide-suffix).pdf: %.md Makefile $(media)
	pandoc $(filter) $< $(slideformat) -o $@ $(incremental) $(pdfoptions)

# Normaler Text
%.html: %.md Makefile $(css-styles) $(media) $(bib)
	pandoc $(filter) --toc $< -o $@ $(numbered) $(htmloptions) $(css) $(math)

%.epub: %.md Makefile $(css-styles) $(media) $(bib)
	pandoc $(filter) --toc $< -o $@ $(numbered) $(htmloptions) $(epub-css) --mathml

%.pdf: %.md Makefile $(media) $(bib)
	pandoc $(filter) --toc $< -o $@ $(numbered) $(pdfoptions)

# Videos (YouTube-Download)

future.mp4:
	youtube-dl https://www.youtube.com/watch?v=8KkW8Ul7Q1I -f mp4 -o $@

# Um Partituren im Lilypond-Format einzubinden, genügt es, die entsprechenden
# Dateien mit der Markdown-Datei zusammen in dieses Verzeichnis zu legen.

# Die folgende Regel generiert dazu eine Grafik im pdf-Format aus einer
# Lilypond-Datei. Neben dem Lilypond-Formatierer wird Ghostscript verwendet,
# um die Grafik auf ihre Bounding Box zurechtzuschneiden. Damit das
# funktioniert, sollte die Partitur nicht mehr als eine Seite umfassen und die
# Standard-Fußzeile in der Lilypond-Partitur unterdrückt werden (tagline = ""
# im \header-Block, vgl. lilypond-score.ly).

%.pdf: %.ly
	lilypond -dno-point-and-click -dbackend=eps -ddelete-intermediate-files -o $@ $< > /dev/null
	rm -rf $@
	(bbox=`gs -o /dev/null -sDEVICE=bbox $@.pdf 2>&1 >/dev/null | grep %%HiResBoundingBox | sed -e 's/%%HiResBoundingBox: \\(.*\\)/\\1/'`; gs -o $@ -sDEVICE=pdfwrite -c "[/CropBox [$$bbox] /PAGES pdfmark" -dUseCropBox -f  $@.pdf) > /dev/null
	rm -f $@-* $@.eps $@.pdf

# Hier verwenden wir das convert-Programm von ImageMagick, um die
# Partitur-Grafik im pdf-Format in png umzuwandeln. Dies wird für das
# HTML-Ausgabeformat benötigt, da nicht alle Anzeigeprogramme die Einbettung
# von Vektorgrafiken im pdf-Format unterstützen (insbesondere Ebook-Reader wie
# z.B. iBooks). Mit der dpi-Variablen wird die gewünschte Auflösung
# festgelegt. Auf diese Weise kann man alle üblichen Bitmap-Formate erzeugen.

dpi = 300

%.png: %.pdf
	convert -density $(dpi) $< -trim +repage $@

# ZIP-Datei erstellen.

zip:
	git archive HEAD --format=zip > $(name).zip

# Aufräumen (Löschen aller erzeugten Dateien). Achtung: 'make realclean'
# löscht auch die aus Lilypond-Partituren erzeugten Grafik-Dateien, die nur
# mittels spezieller Tools erzeugt werden können (s.o.).

clean:
	rm -f $(htmls) $(epubs) $(pdfs) $(html-slides) $(pdf-slides)

realclean: clean
	rm -f $(media)
