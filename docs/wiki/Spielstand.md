# Spielstand

## Speicherort und Ablauf

Der RPG-Spielstand ist versioniertes JSON unter `user://beta3_save.json`. `user://` bezeichnet das Godot-Benutzerverzeichnis der jeweiligen Plattform, nicht den Projektordner. Die Datei wird nicht ins Repository geschrieben.

`RPGProgress` lädt beim Start. Der Spielstand wird automatisch bei Auftragsannahme, jedem erfolgreich gesammelten Beereneintrag und Auftragsabschluss geschrieben. Mit F5 lässt sich der aktuelle Zustand manuell speichern; F9 lädt einen gültigen gespeicherten Stand und setzt die Spielerposition und sichtbaren Beeren entsprechend zurück.

## Datenfelder (Version 1)

| Feld | Bedeutung |
| --- | --- |
| `version` | Formatversion; aktuell `1` |
| `quest_stage` | `0`: nicht begonnen, `1`: aktiv, `2`: abgeschlossen |
| `collected_berries` | Array eindeutiger positiver Beeren-IDs |
| `coins` | Nicht negativer Goldbetrag |
| `player_position` | Zwei Zahlen: X- und Y-Position |

Der initiale Spielstand vor einem ersten Speichern wird durch Standardwerte im Autoload dargestellt; die Datei muss daher nicht schon beim ersten Start vorhanden sein.

## Ungültige oder inkompatible Dateien

Fehlt die Datei, ist sie ungültiges JSON oder stimmt das Versionsfeld nicht mit Version 1 überein, kann dieser Code sie nicht laden. Ebenso werden ungültige Feldtypen oder eine Position mit nicht genau zwei Zahlen abgelehnt. Bei erfolgreichem Laden werden ungültige beziehungsweise doppelte Beeren-IDs ausgelassen, Auftragsstatus und Gold begrenzt und die Spielerposition beim Anwenden auf die Welt begrenzt.

Es gibt derzeit keine dokumentierte Migration zwischen Save-Versionen. Bei Änderungen am JSON-Format muss `SAVE_VERSION` erhöht und eine passende Migrations- oder Fehlerbehandlung geplant werden. Keine echten Benutzerspielstände in Issues, Pull Requests oder Commits hochladen.
