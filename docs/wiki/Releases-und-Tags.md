# Releases und Git-Tags

## Aktueller Stand

Laut lokalem Repository-Stand gibt es derzeit keine Git-Tags oder GitHub-Releases. Eine konkrete erste Versionsnummer ist noch nicht freigegeben. Versionsnummern in Beispielen sind keine existierenden Veröffentlichungen.

## Empfohlene Versionsregel

Für veröffentlichte Versionen eignet sich semantische Versionierung mit `v`-Präfix:

- `vMAJOR.MINOR.PATCH`, zum Beispiel `v1.2.3`
- `MAJOR`: inkompatible Änderungen
- `MINOR`: neue, rückwärtskompatible Funktionen
- `PATCH`: rückwärtskompatible Fehlerkorrekturen

Für einen Prototyp kann eine erste Version `v0.x.y` sein, sofern die Projektverantwortlichen die Veröffentlichung ausdrücklich freigeben.

## Release-Checkliste

- Gewünschten Commit und Versionsnummer freigeben.
- Projekt mit Godot 4.7 importieren und Start, Quest, Eingaben und Spielstand prüfen.
- Release-Notiz mit Änderungen, Einschränkungen und Kompatibilität vorbereiten.
- Auf GitHub einen Release-Tag erstellen, der auf den geprüften Commit zeigt.
- GitHub-Release mit derselben Versionsnummer und Release-Notiz veröffentlichen.
- Download-Artefakte nur beifügen, wenn ein konkreter Export erstellt und geprüft wurde.
- Nach Veröffentlichung keine bestehenden Tags verschieben oder wiederverwenden.

Git-Tags sind Versionsmarken auf Commits. GitHub-Repository-Topics sind dagegen Suchbegriffe. Eine Wiki-Seite zu Releases ersetzt weder einen Tag noch einen veröffentlichten Build.
