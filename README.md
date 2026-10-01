# Beta3 RPG

Ein kleines 2D-RPG in Godot 4.7: Sprich mit Mira, sammle drei Waldbeeren und kehre für deine Belohnung ins Dorf zurück. Das Projekt verbindet diesen spielbaren Ausschnitt mit dem Menü-, Audio- und Szenenlade-System von [Maaack's Godot Game Template](https://github.com/Maaack/Godot-Game-Template).

> **Projektstatus:** spielbarer Prototyp. Im Repository sind derzeit keine Git-Tags oder veröffentlichten Releases vorhanden.

## Loslegen

1. [Godot 4.7](https://godotengine.org/download/) installieren.
2. Dieses Repository klonen oder als ZIP herunterladen.
3. Im Godot-Projektmanager den Projektordner importieren beziehungsweise `project.godot` öffnen.
4. Das Projekt ausführen. Das Hauptmenü öffnet sich; **Neues Spiel** startet die RPG-Welt.

## Spielen

| Aktion | Taste |
| --- | --- |
| Bewegen | W, A, S, D oder Pfeiltasten |
| Mit Mira sprechen / Beere sammeln | E |
| Spielstand speichern | F5 |
| Spielstand laden | F9 |

Sprich im Dorf mit Mira, folge dem Weg nach Osten und sammle die drei Beeren im Wald. Kehre zu Mira zurück, um den Auftrag abzuschliessen und 10 Gold zu erhalten. Der Spielstand wird lokal unter `user://beta3_save.json` gespeichert; er wird nicht mit dem GitHub-Repository synchronisiert.

## Dokumentation

- [Dokumentationsübersicht](docs/README.md)
- [Spielanleitung](docs/wiki/Spielanleitung.md)
- [Technische Architektur](docs/wiki/Technische-Architektur.md)
- [Spielstandformat](docs/wiki/Spielstand.md)
- [Entwickeln und beitragen](CONTRIBUTING.md)
- [GitHub-Wiki, Tags und Releases einrichten](docs/GITHUB.md)
- [Release- und Tag-Ablauf](docs/wiki/Releases-und-Tags.md)
- [Plugin-Audit](GODOT_PLUGIN_REVIEW.md)
- [Drittanbieter- und Asset-Quellen](ATTRIBUTION.md)

Die Dateien unter `docs/wiki/` sind als Wiki-Inhalte vorbereitet und lassen sich in ein GitHub-Wiki übernehmen. Diese Repository-Änderung erstellt oder konfiguriert das separate GitHub-Wiki selbst nicht.

## Projektaufbau

- `project.godot` — Godot-Konfiguration, Autoloads und Eingaben
- `scenes/world.tscn`, `scenes/berry.tscn`, `scripts/` — spielbarer RPG-Ausschnitt
- `scenes/opening/`, `scenes/menus/`, `scenes/game/` — Startablauf und Template-Spielhülle
- `addons/maaacks_*` — integrierte Menüs, Szenenladung sowie Audio-Controller
- `docs/wiki/` — vorbereitete Seiten für das GitHub-Wiki

Die Beispiel-Level des Templates sind im Projekt enthalten, werden aber nicht als RPG-Spielinhalt verwendet. Weitere Godot-Plugins und Plugin-Archive sind nicht automatisch Projektabhängigkeiten; siehe [Plugin-Audit](GODOT_PLUGIN_REVIEW.md).

## Lizenz und Hinweise

Beachte `LICENSE.txt` sowie die jeweiligen Lizenz- und Attributionsdateien der Add-ons und Assets. Die Quellen der übernommenen Bestandteile sind in [ATTRIBUTION.md](ATTRIBUTION.md) dokumentiert.
