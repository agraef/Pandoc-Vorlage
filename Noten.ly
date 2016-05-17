\version "2.18"
% Damit das Notenbeispiel automatisch auf die minimale Größe zurechtgeschnitten
% und kein Platz verschendet wird, benötigt man ggf. folgende Einstellungen:
% tagline = "" entfernt die automatische Fußzeile
% indent = 0 (optional) keine Einrückung in der ersten Notenzeile
% ragged-right = ##t (optional) kein Blocksatz
\header {
  tagline = ""
  composer = ""
}
\paper {
  indent = 0
  ragged-right = ##t
}
\layout{}
\relative c' {
\key e \major e8 fis gis e fis8 b,4. | e2\fermata \bar "|."
}
