# Plugins

Dieses Verzeichnis enthält die gesammelten Godot-Plugin- und Asset-Archive des Projekts. Sie sind **keine automatischen Projektabhängigkeiten**: was integriert ist, liegt als entpacktes Add-on unter `addons/`, nicht hier. Die Bewertung aller Archive steht in [GODOT_PLUGIN_REVIEW.md](../GODOT_PLUGIN_REVIEW.md).

## Struktur

| Ordner | Inhalt | Beispiele |
| --- | --- | --- |
| `archives/foundation/` | Die gewählte Projektbasis (Maaack's Game Template, bereits unter `addons/maaacks_*` integriert) | Godot-Game-Template |
| `archives/tile-map/` | Kandidaten für Tile-/Map-Authoring | BetterTileEditor, AutotileEditor |
| `archives/gameplay/` | Laufzeitsysteme: Quests, Inventar, State Charts, Dialoge, Skills | Questify, p0nni_inventory_system, godot-statecharts |
| `archives/testing/` | Test- und QA-Werkzeuge | GUT, input-audit-lite, loc-audit-lite |
| `archives/ui/` | UI-, HUD- und Menü-Systeme | gohud, UI_Builder |
| `archives/editor-tools/` | Editor-Komfort, keine Spielfunktionen | Snippets, Theme Explorer, externe Editoren |
| `archives/level-editor/` | Alternative Level-/Welt-Editoren | WorldEditor, dioptra |
| `archives/art/` | Asset- und Grafikpakete (keine Plugins) | 1_Free_Pack, MorbidEmber |
| `archives/graphics-tools/` | Bild-, Sprite- und Form-Editoren | Sprite-Editor, polygon2d_editor |
| `archives/3d/` | 3D-Werkzeuge und native Erweiterungen | terrabrush, CSG-Editor |
| `archives/templates/` | Alternative Templates und Frameworks | TakinGodotTemplate, fuse |
| `archives/localization/` | Lokalisierungs-Editoren | Godot4LocalizationEditor, CSVLocaleEditor |
| `archives/utilities/` | Sonstige Werkzeuge und Referenzen | JSON-Editoren, awesome-godot |

## Integration stückweise

Archive werden nicht pauschal entpackt. Pro Schritt wird höchstens ein Plugin integriert:

1. **Bedarf bestätigen** — nur wenn eine konkrete Anforderung das Plugin rechtfertigt (siehe Review-Tabellen).
2. **Archiv finden** — aus dem passenden `archives/`-Unterordner; Bewertung und Lizenz in [GODOT_PLUGIN_REVIEW.md](../GODOT_PLUGIN_REVIEW.md) prüfen.
3. **Entpacken** — den `addons/…`-Inhalt des Archivs nach `addons/` kopieren.
4. **Aktivieren** — den Plugin-Pfad in `project.godot` unter `[editor_plugins]` ergänzen; für Plugin-Updates zusätzlich unter `[plugin_updater]` eintragen.
5. **Testen** — Projekt in Godot 4.7 importieren, bestehenden Ablauf (Startmenü, Welt, Quest, F5/F9-Speicherstand) und die neue Funktion prüfen.
6. **Dokumentieren** — Entscheidung und Ergebnis in [GODOT_PLUGIN_REVIEW.md](../GODOT_PLUGIN_REVIEW.md) nachziehen und bei Bedarf [ATTRIBUTION.md](../ATTRIBUTION.md) ergänzen.

## Sicherheit und Lizenzen

Archive aus `archives/` bleiben unverändert im Repository und werden erst nach Lizenz- und Kompatibilitätsprüfung entpackt. Lizenzpflichten (z. B. GPL-3.0 bei BetterTileEditor) müssen vor der Übernahme akzeptiert werden.
