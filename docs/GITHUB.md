# GitHub-Einrichtung: Wiki, Topics und Tags

Dieses Dokument bereitet die GitHub-Projektseite vor und unterscheidet die drei Dinge, die häufig alle „Tags“ genannt werden: Wiki-Seiten, Repository-Topics und versionierte Git-Tags.

## Repository-Topics

Als passende GitHub-Topics bieten sich an:

`godot`, `godot-engine`, `godot-4`, `2d-game`, `rpg`, `godot-rpg`, `gdscript`, `game-template`

Topics sind Suchbegriffe für das Repository, keine Releases. Sie können auf GitHub in den Repository-Einstellungen beziehungsweise über **About → Edit repository details** gepflegt werden.

## Git-Tags und Releases

Für veröffentlichte Versionen wird semantische Versionierung mit `v`-Präfix empfohlen, zum Beispiel `v0.1.0` für eine ausdrücklich freigegebene erste öffentliche Version. Derzeit gibt es im lokalen Repository **keine Tags und keine Releases**; die Beispielversion ist keine Behauptung, dass bereits eine Veröffentlichung stattgefunden hat.

Erst nach Freigabe eines konkreten Release-Kandidaten:

1. Änderungen und bekannte Einschränkungen prüfen; Godot-Projekt importieren und den Spielablauf manuell testen.
2. Eine Release-Notiz mit Änderungen, Kompatibilität, bekannten Problemen und gegebenenfalls Downloads erstellen.
3. Den Versions-Tag auf den freigegebenen Commit setzen und pushen.
4. Auf GitHub unter **Releases → Draft a new release** denselben Tag auswählen und die Release-Notiz veröffentlichen.

Tags sind dauerhaft an Commits gebunden. Bereits veröffentlichte Tags nicht stillschweigend verschieben oder wiederverwenden. Keine Tags für unveröffentlichte, nicht geprüfte oder nur beispielhafte Versionsnummern anlegen.

## GitHub-Wiki

Die Wiki-Texte liegen als Markdown unter [`wiki/`](wiki/Home.md). Zum Veröffentlichen muss das Wiki in den GitHub-Repository-Einstellungen aktiviert sein; anschliessend können die Seiten dort angelegt oder über das separate Wiki-Git-Repository übertragen werden. Wiki-Inhalte sind ein eigenes Git-Repository und werden durch Änderungen an diesem Quellcode-Repository **nicht** automatisch aktualisiert.

Die vorbereiteten Wiki-Seiten sind:

- [Home](wiki/Home.md)
- [Spielanleitung](wiki/Spielanleitung.md)
- [Technische Architektur](wiki/Technische-Architektur.md)
- [Spielstand](wiki/Spielstand.md)
- [Entwicklung](wiki/Entwicklung.md)
- [Releases und Tags](wiki/Releases-und-Tags.md)

Die Sidebar-Datei [`_Sidebar.md`](wiki/_Sidebar.md) kann als Seitenleiste des GitHub-Wikis verwendet werden. GitHub-seitige Einstellungen, Topics, Tags und Wiki-Seiten werden hier nicht unmittelbar verändert.

## Vor dem Freischalten prüfen

- Repository-Sichtbarkeit und gewünschte Zielgruppe klären.
- Prüfen, ob die Projektlizenz für den gesamten Repository-Inhalt zutreffend ist; Add-ons und Assets können eigene Lizenzbedingungen haben.
- Wiki-Inhalte nach jeder relevanten Änderung an den Projektdateien aktualisieren.
- Release-Notizen und Tags nur für tatsächlich geprüfte und freigegebene Builds veröffentlichen.
