---
title: Markdown - Kurze Einführung
author: Albert Gräf, Musikwissenschaft, JGU
date: Oberseminar SoSe 2016
toc: false
csl: styles/csl/chicago-author-date-de.csl
bibliography: Markdown.bib
locale: de-DE
lang: de
papersize: A4
geometry: margin=2cm
mainfont: Minion Pro
monofont: Bitstream Vera Sans Mono
fontfamily: mathpazo
fontsize: 12pt
urlcolor: blue
---

# Einführung

[Markdown] ist ein textbasiertes Dokumentformat, mit dem man auf einfache
Weise formatierte Textdokumente erstellen kann. Markdown unterstützt
Hervorhebungen in *Kursivschrift*, **Fettdruck** und `Schreibmaschinenschrift`
(nützlich z.B. für Code-Beispiele), Formeln: $a^2+b^2=c^2$, und eine ganze
Reihe weiterer Textelemente wie z.B. Überschriften, Aufzählungen, Zitate,
Codeblöcke, eingebettete Mediendateien u.v.m. Mit dem quelloffenen Program
[Pandoc] lassen sich Markdown-Dokumente in eine Vielzahl von Zielformaten
umwandeln, z.B. PDF, HTML und EPUB [@hasecke_zen_2015; @kofler_markdown_2013].

[Markdown]: https://de.wikipedia.org/wiki/Markdown
[Pandoc]: http://pandoc.org

# Vorteile von Markdown

- **einfaches Textformat** (ASCII bzw. UTF8), benötigt kein spezielles
  Textverarbeitungsprogramm und wird auch noch in 50 Jahren lesbar sein

- **schnelle** und **einfache** Eingabe mit jedem Texteditor

- Umwandlung in **verschiedene Ausgabeformate** mit Pandoc
  (HTML, PDF, EPUB, usw.)

- **Mediendateien** können verlinkt und (bei HTML-Ausgabe) auch direkt
  eingebettet werden

- automatische Verwaltung von **Querverweisen** und **Literaturangaben**
  (pandoc-crossref, pandoc-citeproc)

# Nachteile von Markdown

- Vielzahl **unterschiedlicher Dialekte**, die unterschiedliche Elemente und
  Ausgabeformate unterstützen (**Lösung:** pandoc verwenden!)

- zur formatierten Anzeige benötigt man i.d.R. **spezielle Software**

- nicht [WYSIWYG], erschwert **komplexes Seiten-Layout** (Folien)

- **direkte Einbettung** von Mediendateien (Audio, Video) bislang nur in den
  HTML-basierten Ausgabeformaten

- **spezielle Formatierungen** erfordern u.U. direkte HTML- bzw. LaTeX-Eingabe

[WYSIWYG]: https://de.wikipedia.org/wiki/WYSIWYG

# Formeln

Formeln werden in gewohnter TeX-Qualität in der PDF-Ausgabe gesetzt, und sind
mit [MathML] oder [MathJax] auch im HTML-Format und E-Büchern kein Problem.

$$ f(t) = \sum_{k=0}^\infty a_k \sin(2\pi k\nu_0 t + \phi_k) $$

- [MathML] ist schneller, wird aber derzeit nur in Firefox, Safari und
  Ebook-Readern unterstützt.

- [MathJax] bietet die bessere Ausgabequalität, benötigt aber externe
  Javascript-Module, ist relativ langsam und funktioniert *nicht* in
  Ebook-Readern.

[MathML]: https://www.w3.org/Math/
[MathJax]: https://www.mathjax.org/

# Abbildungen

Partituren können z.B. mit [Lilypond] erstellt und dann als Grafik eingefügt
werden ([@fig:lilypond]).

![Notenbeispiel](lilypond-score.png){#fig:lilypond width=100%}

[Lilypond]: http://lilypond.org/

# Tabellen

| Komponist    | Nationalität | Lebensdaten | Wichtige Werke                 |
|:-------------|:-------------|:------------|:-------------------------------|
| Monteverdi   | Italien      | 1567-1643   | "L'Arianna"-Oper (1623)        |
| J.S. Bach    | Deutschland  | 1685-1750   | "Johannes-Passion" (1724)      |
| Telemann     | Deutschland  | 1681-1767   | "Brockes-Passion" (1716)       |
| A. Scarlatti | Italien      | 1660-1725   | "Rosmene" (1686)               |
| Couperin     | Frankreich   | 1668-1733   | "Les bagatelles" (1717)        |
| D. Scarlatti | Italien      | 1685-1757   | Cembalosonaten                 |
| Händel       | Deutschland  | 1685-1759   | "Wassermusik" (1717)           |
| Vivaldi      | Italien      | 1678-1741   | "Die vier Jahreszeiten" (1725) |

Table: Beispieltabelle {#tbl:Beispieltabelle}

Pandoc unterstützt diverse gängige Eingabe-Formate für Tabellen.\
(hier z.B. das "Pipe"-Format, siehe [@tbl:Beispieltabelle])

# Medien

- Als Link: [ABC TV: "What The Future Sounded Like" (2006)](https://www.youtube.com/watch?v=8KkW8Ul7Q1I)

- Als eingebettete Mediendatei (HTML5):

    <center>
    <video width="480" height="320" controls="true">
      <source src="future.mp4" type="video/mp4"/>
	    wird nur in der HTML-Ausgabe unterstützt (HTML5-kompatibler Browser
        wird benötigt).
    </video>
    </center>

# Folien und E-Bücher

- **[dzslides]:** einfaches HTML-Format, eigenständige Dokumente (verwendete
  Bild- und Mediendateien muss man allerdings beim Versenden dazulegen)

- **[revealjs]:** beliebtes HTML-Format, sieht besser aus und bietet viele
  zusätzliche Funktionen; Nachteil: benötigt zusätzliche Javascript-Module
  (nicht eigenständig)

- **[beamer]:** PDF (eigenständig), Folien in Druckqualität; wesentlicher
  Nachteil: keine eingebetteten Mediendateien

- **[epub]:** HTML-basiertes E-Buch-Format (eigenständig), kann von den meisten
  Ebook-Readern (außer Kindle) gelesen werden

- **Tipp:** automatische Wandlung von EPUB in das MOBI-Format (Amazon/Kindle)
  ist möglich z.B. mit [KindleGen] (mit Einschränkungen)

# revealjs-Bedienung

- Leertaste, Pfeiltasten, `n` und `p`: Navigation

- `Esc`: Folien-Übersicht

- `f`: Vollbild-Modus

- `b` oder `.`: Pause (blendet Folien aus)

- `s`: separates Browser-Fenster mit Folien-Vorschau / Uhr / Notizen

<div class="notes">
---

- Notizen zu Folien können per HTML-Code eingefügt werden
- werden *nicht* auf der Folie angezeigt
- Anzeige wird derzeit nur von `reveal.js` unterstützt
</div>

[dzslides]: https://github.com/paulrouget/dzslides
[revealjs]: https://github.com/hakimel/reveal.js
[beamer]: https://de.wikipedia.org/wiki/Beamer_(LaTeX)
[epub]: https://de.wikipedia.org/wiki/EPUB
[KindleGen]: http://www.amazon.com/gp/feature.html?ie=UTF8&docId=1000765211

# Editoren

Markdown-Dateien können mit jedem Texteditor bearbeitet werden, es empfiehlt
sich aber die Verwendung eines Texteditors mit spezieller
Markdown-Unterstützung und -Vorschau.

- [Emacs] bzw. [Aquamacs] (Open-Source; Linux, Mac, Windows)

- [Marked] (nur Vorschau; Mac)

- [Atom] (Open-Source; Linux, Mac, Windows)
    - Vorschau mit [Markdown Preview Plus]

- [Sublime Text] (Linux, Mac, Windows)

- [Draft] (Android) und [Byword] (iOS)

[Emacs]: https://www.gnu.org/software/emacs/
[Aquamacs]: http://aquamacs.org/
[Atom]: https://atom.io/
[Markdown Preview Plus]: https://atom.io/packages/markdown-preview-plus
[Marked]: http://marked2app.com/
[Sublime Text]: https://www.sublimetext.com/
[Draft]: https://play.google.com/store/apps/details?id=com.mvilla.draft
[Byword]: https://bywordapp.com/

# Nützliche Helfer

- **[Zotero](https://www.zotero.org/):** Bibliographieren mit Online-Funktionen

    - Import von bibliographischen Daten in diversen Formaten, auch direkt aus
      Online-Literaturdatenbanken wie [BMS], [RISM] und [Google Scholar]
	- Export ins [BibTeX]-Format, Einfügen der Zitierschlüssel mit [BBT]
	- umfangreiches [Repositorium] mit Zitierstilen im [CSL]-Format
	- BibTeX-Datenbanken und CSL-Dateien können direkt mit Pandoc verwendet
	  werden

- **[Copy as Markdown](https://github.com/chitsaou/copy-as-markdown):** kopiert
  URLs von WWW-Seiten, Links und Bildern als Markdown-Links in die
  Zwischenablage (Plugin für Chrome und Firefox)

- **[Markdown Service Tools](http://brettterpstra.com/projects/markdown-service-tools/):**
  OS X-Dienste für Markdown (Formatieren, Konvertieren, Links in
  Markdown-Syntax einfügen, usw.); vom [Marked]-Entwickler, nur für den Mac

[Repositorium]: https://www.zotero.org/styles
[BibTeX]: http://www.bibtex.org/de/
[BBT]: https://github.com/retorquere/zotero-better-bibtex
[CSL]: http://citationstyles.org/
[BMS]: http://www.musikbibliographie.de/
[RISM]: http://de.rism.info/
[Google Scholar]: https://scholar.google.de/

# Benötigte Software

- pandoc, pandoc-citeproc (<http://pandoc.org/>)

- pandoc-crossref (<https://github.com/lierdakil/pandoc-crossref>)

- TeX für die PDF-Ausgabe (vgl. <http://pandoc.org/installing.html>)

- GNU make zur Automatisierung (z.B. <http://www.mingw.org/>)

- (ggf. [Git] für Versionskontrolle und kollaboratives Schreiben)

- Falls **Lilypond-Partituren** verwendet werden sollen, benötigt man außerdem
  [Lilypond], sowie [Ghostscript] und [ImageMagick] zum Zurechtschneiden und
  Umwandeln der Grafik-Formate.

[Git]: https://de.wikipedia.org/wiki/Git
[Ghostscript]: http://www.ghostscript.com/
[ImageMagick]: http://www.imagemagick.org/

# Installation von TeX

Wird für die PDF-Ausgabe benötigt.

- **Linux:** in den Paket-Repositorien ([TeXLive] installieren)

- **Mac OS X:** [TeXLive] aus [MacPorts] installieren, oder [MacTeX]

- **Windows:** [TeXLive](http://www.dante.de/tex/tl-install-windows.html),
  oder [MikTeX]

[MacPorts]: https://www.macports.org/
[TeXLive]: https://www.tug.org/texlive/
[MacTeX]: https://tug.org/mactex/
[MikTeX]: http://miktex.org/

# Installation von GNU Make

Wird benötigt zum automatisierten Konvertieren per "Makefile".

- **Linux:** üblicherweise Teil des Betriebssystems, ansonsten in den
  Paket-Repositorien

- **Mac OS X:** Teil der Apple-SDK [Xcode], installieren mit:
  `xcode-select --install`

- **Windows:** gibt es als Download z.B. bei [GnuWin32] (separates Programm)
  oder [MinGW] (Bestandteil von [MSYS]), `make.exe` irgendwo unter `PATH`
  installieren bzw. `PATH` entsprechend setzen

[Xcode]: https://developer.apple.com/xcode/
[GnuWin32]: http://gnuwin32.sourceforge.net/packages/make.htm
[MinGW]: http://www.mingw.org/
[MSYS]: http://www.mingw.org/wiki/msys

# Literaturverzeichnis
