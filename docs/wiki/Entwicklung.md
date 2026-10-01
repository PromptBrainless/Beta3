# Entwicklungsleitfaden

## Voraussetzungen

- Godot 4.7
- Git, falls das Repository geklont wird

Das Projekt verwendet GDScript und Godot-Szenen. Eine externe Paketinstallation ist für den derzeit dokumentierten Spielablauf nicht vorgesehen.

## Projekt öffnen und prüfen

1. Repository klonen oder herunterladen.
2. `project.godot` in Godot 4.7 öffnen.
3. Import und Editor-Fehler prüfen.
4. Das Projekt ausführen; Startszene ist `scenes/opening/opening.tscn`.
5. Menü, RPG-Welt, Mira-Quest, alle drei Beeren sowie manuelles und automatisches Speichern prüfen.

Es gibt kein CI-System für den RPG-Ablauf. Für den Quest-Loop existiert ein Headless-Test unter `tests/quest_loop_test.tscn` (Skript `tests/quest_loop_test.gd`): `run/main_scene` in `project.godot` zeitweise auf diese Szene setzen und das Projekt mit `godot --headless` starten; der Test deckt Bewegung, Kollision, Dialog, Questfortschritt sowie Speichern/Laden ab und endet mit `ALL CHECKS PASSED` oder einer Fehlerliste. Zusätzlich Gameplay-Änderungen durch einen manuellen Durchlauf verifizieren und die ausgeführten Prüfungen im Pull Request nennen.

## Wo Änderungen hingehören

- Spielwelt/Quest: `scenes/world.tscn` und `scripts/`
- Startmenü und Spielhülle: `scenes/menus/` und `scenes/game/`
- Spielstandformat: `scripts/rpg_progress.gd` und [Spielstand](Spielstand.md)
- Eingaben: `project.godot` und `scripts/world.gd`
- GitHub-Wiki-Material: `docs/wiki/`
- Plugin- und Asset-Archive: `plugins/archives/` (nur Lager, Integration siehe [plugins/README.md](../../plugins/README.md))

Die `addons/maaacks_*`-Verzeichnisse stammen aus dem Template. Änderungen an übernommenen Add-ons sollten nur erfolgen, wenn sie für das Projekt nötig sind. Der Plugin-Audit und die Attributionsdateien helfen bei der Prüfung von Herkunft, Lizenz und Integrationsstatus. Weitere Plugins aus `plugins/archives/` werden stückweise integriert: höchstens ein Plugin pro Schritt, vorher Lizenz und Kompatibilität prüfen, nachher den bestehenden Spielablauf testen und die Entscheidung im Plugin-Audit dokumentieren.

## Änderungen beitragen

Vor grösseren oder spielverändernden Arbeiten zuerst ein Issue eröffnen, um Umfang und gewünschtes Verhalten abzustimmen. Pull Requests sollten Änderungen eng begrenzen, Bedienungs- oder Speicherformatänderungen dokumentieren und manuelle Tests beschreiben. Details siehe [CONTRIBUTING.md](../../CONTRIBUTING.md).
