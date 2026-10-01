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

Es ist im Repository kein eigenständiges Test- oder CI-System für den RPG-Ablauf dokumentiert. Verifiziere Gameplay-Änderungen daher durch einen manuellen Durchlauf und nenne die ausgeführten Prüfungen im Pull Request.

## Wo Änderungen hingehören

- Spielwelt/Quest: `scenes/world.tscn` und `scripts/`
- Startmenü und Spielhülle: `scenes/menus/` und `scenes/game/`
- Spielstandformat: `scripts/rpg_progress.gd` und [Spielstand](Spielstand.md)
- Eingaben: `project.godot` und `scripts/world.gd`
- GitHub-Wiki-Material: `docs/wiki/`

Die `addons/maaacks_*`-Verzeichnisse stammen aus dem Template. Änderungen an übernommenen Add-ons sollten nur erfolgen, wenn sie für das Projekt nötig sind. Der Plugin-Audit und die Attributionsdateien helfen bei der Prüfung von Herkunft, Lizenz und Integrationsstatus.

## Änderungen beitragen

Vor grösseren oder spielverändernden Arbeiten zuerst ein Issue eröffnen, um Umfang und gewünschtes Verhalten abzustimmen. Pull Requests sollten Änderungen eng begrenzen, Bedienungs- oder Speicherformatänderungen dokumentieren und manuelle Tests beschreiben. Details siehe [CONTRIBUTING.md](../../CONTRIBUTING.md).
