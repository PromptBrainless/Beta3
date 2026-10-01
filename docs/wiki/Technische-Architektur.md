# Technische Architektur

## Start- und Szenenfluss

`project.godot` startet `scenes/opening/opening.tscn`. Die Menü-Konfiguration verweist auf `scenes/menus/main_menu/main_menu.tscn`; das Spielmenü startet `scenes/game/game.tscn`. Deren `LevelManager` lädt als Start-Level `scenes/world.tscn`.

Die `world.tscn` enthält Spieler, Mira und die drei Beeren. Die Welt wird durch `scripts/world.gd` gezeichnet und verwaltet Interaktion, HUD und Eingaben.

## RPG-Skripte

| Datei | Aufgabe |
| --- | --- |
| `scripts/world.gd` | Spielwelt, HUD, Laufzeit-Eingaben, Interaktion und Aktualisierung der Beeren |
| `scripts/player.gd` | Bewegung und Begrenzung innerhalb der Welt |
| `scripts/villager.gd` | Miras Dialoge sowie Annahme und Abgabe des Auftrags |
| `scripts/berry.gd` | Interaktionsprüfung und einmaliges Einsammeln einer Beere |
| `scripts/rpg_progress.gd` | Auftragsstatus, gesammelte Beeren, Gold und versioniertes JSON-Speichern |
| `scripts/level_and_state_manager.gd` | Verknüpfung des Template-Level-Managers mit Template-Spielzustand |

`RPGProgress` wird in `project.godot` als Autoload registriert. Die separate Template-Architektur (Menüs, Szenenlader, Audio und Template-Spielzustand) bleibt davon getrennt.

## Welt und Interaktion

- Weltgrösse: 1920 × 1088 Einheiten; Kachelraster: 32 Einheiten.
- Startposition des Spielers: ungefähr (352, 272).
- Miras Interaktionsradius: 64 Einheiten; Beerenradius: 48 Einheiten.
- Die drei Beeren besitzen eindeutige IDs 1, 2 und 3.
- Spielereingaben werden während eines sichtbaren Dialogs pausiert.
- Bewegung und geladene Spielerposition werden auf die Weltgrenzen beschränkt.

## Eingaben

`project.godot` definiert Standard-Eingaben und `world.gd` stellt die für den RPG-Ausschnitt benötigten WASD-/Pfeiltasten-, Interaktions-, Speicher- und Ladeaktionen sicher. Änderungen an der Steuerung sollten beide Orte berücksichtigen, damit Editor-Einstellungen und Laufzeitverhalten konsistent bleiben.
