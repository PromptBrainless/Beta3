# Projektstatus und offene Punkte

Stand: 2026-10-01

## Ausgangslage

Beta3 ist ein kleiner 2D-RPG-Prototyp auf Basis von Godot 4.7. Das Repository ist lokal sauber; offene Implementierungsaufgaben sind nicht als TODO-Liste im Code erfasst. Die untenstehenden Punkte stammen aus dem Plugin-Audit und der Projekt-/GitHub-Dokumentation.

## Offen vor einer belastbaren Freigabe

- [x] **Headless-Import mit Godot 4.7:** Klassen- und Asset-Import laufen durch. Beim vollständigen Headless-Editorstart meldet das Template-Plugin beim automatischen Thumbnail-Speichern `Parameter "t" is null`; das ist im Dummy-Renderer nicht weiter verifiziert und ersetzt keinen GUI-Editorcheck.
- [x] **Szenen-Smoke-Test:** Hauptszene und `scenes/world.tscn` starten headless ohne Skript- oder Ressourcenfehler. Beim künstlichen Beenden der Hauptszene meldet Godot eine einzelne geleakte `ObjectDB`-Instanz mit orphan `RID`-StringName; der direkte Weltstart beendet sich ohne diese Warnung.
- [x] **Headless-Integrationsprobe:** Questannahme, drei Beeren, 10-Gold-Abschluss, F5/F9-Wiederherstellung, Bewegung und Kollision an Mira erfolgreich geprüft. Dabei wurde ein Ladefehler behoben: Godot liefert JSON-Zahlen als `float`; ganzzahlige Werte werden jetzt geprüft und vor dem Laden konvertiert.
- [ ] **GUI-Prüfung:** Darstellung, tatsächliche Tastaturbedienung und normaler Spielabschluss sind noch nicht visuell/manuell geprüft.
- [ ] **Zielplattform festlegen:** Bis zu einer abweichenden Entscheidung gilt Desktop als Arbeitsannahme. Android oder Web erfordern eine erneute Prüfung von Add-ons, nativen Erweiterungen, Eingaben und Export.
- [ ] **Drive-Grundlagen einbeziehen:** Der verlinkte Google-Drive-Ordner war für das bisherige Audit nicht lesbar. Die dortigen Plugins/Grundlagen sind daher nicht inventarisiert oder bewertet.

## Später oder nur bei Bedarf

- [ ] **Plugins einzeln evaluieren:** Erst bei konkretem Bedarf jeweils höchstens ein Add-on integrieren; Godot-Kompatibilität, Lizenz, Datenmodell und Export prüfen und danach den bestehenden Spielablauf erneut testen. Die Archive unter `plugins/archives/` sind keine aktiven Abhängigkeiten.
- [ ] **Assets mit ungeklärter Lizenz zurückstellen:** `Card_Game_GFX` und `natural_lut` haben im Audit keine Lizenzdatei. Nicht verwenden oder weitergeben, bevor die Nutzungsrechte geklärt sind.
- [ ] **Save-Migration planen, falls das Format geändert wird:** Bei einer Änderung `SAVE_VERSION` erhöhen und Migration oder eine klare Fehlerbehandlung für ältere Spielstände ergänzen. Für das aktuelle Format ist keine Migration als unmittelbare Aufgabe dokumentiert.
- [ ] **GitHub-Wiki veröffentlichen, falls gewünscht:** Wiki aktivieren und vorbereitete Markdown-Seiten ins separate Wiki-Repository übertragen. Änderungen am Projekt-Repository aktualisieren das Wiki nicht automatisch.
- [ ] **Release erst nach Prüfung und ausdrücklicher Freigabe:** Eine konkrete Version ist nicht festgelegt; lokal sind keine Git-Tags oder Releases dokumentiert. Vorher Build und Spielablauf testen, Notizen erstellen und den freigegebenen Commit verwenden.
- [ ] **Repository-Topics pflegen, falls gewünscht:** Die vorgeschlagenen Suchbegriffe aus `docs/GITHUB.md` sind noch keine GitHub-Einstellungen.

## Verweise

- [Godot-Plugin-Audit](../GODOT_PLUGIN_REVIEW.md)
- [Entwicklungsleitfaden](wiki/Entwicklung.md)
- [Spielstandformat](wiki/Spielstand.md)
- [GitHub-Einrichtung: Wiki, Topics und Tags](GITHUB.md)
- [Release- und Tag-Ablauf](wiki/Releases-und-Tags.md)
