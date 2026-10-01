# Mitwirken an Beta3 RPG

Danke für dein Interesse an Beta3 RPG. Das Repository enthält einen Godot-4.7-Prototyp; grössere Spiel- oder Architekturänderungen sollten zuerst in einem GitHub-Issue abgestimmt werden.

## Änderung vorbereiten

1. Repository forken oder einen passenden Branch erstellen.
2. Änderungen auf den gewünschten Umfang begrenzen.
3. Godot 4.7 öffnen und das Projekt importieren.
4. Bei Änderungen am Spielablauf mindestens den Start, die betroffene Funktion und den Questablauf testen.
5. Bei Änderungen an Eingaben, UI oder Speichern auch die relevanten Steuerungs- und Spielstandfälle prüfen.

Ein separates automatisiertes Test- oder CI-System für das RPG ist derzeit nicht dokumentiert. Beschreibe deshalb im Pull Request genau, was du manuell geprüft hast und welche Bereiche ungeprüft sind.

## Pull Request

Eröffne den Pull Request gegen den Standard-Branch des Repositorys und beschreibe:

- das Problem oder den gewünschten Zweck,
- die wesentlichen Änderungen,
- die durchgeführten Tests und deren Ergebnis,
- sichtbare Änderungen mit Screenshots, wenn hilfreich,
- Änderungen oder Einschränkungen am Spielstandformat.

## Lizenzen und Quellen

Verwende nur Assets und Code, deren Lizenz die geplante Verwendung erlaubt. Ergänze oder korrigiere Quellenangaben in `ATTRIBUTION.md` und prüfe die jeweilige Lizenzdatei des betroffenen Add-ons. Der Projekt- und Plugin-Audit (`GODOT_PLUGIN_REVIEW.md`) ist keine allgemeine Freigabe für sämtliche im Repository vorhandenen Archive.

## Verwandte Dokumente

- [Code of Conduct](CODE_OF_CONDUCT.md)
- [Entwicklungsleitfaden](docs/wiki/Entwicklung.md)
- [Spielstandformat](docs/wiki/Spielstand.md)
