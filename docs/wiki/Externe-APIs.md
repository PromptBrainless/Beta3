# Externe APIs und API-Schlüssel

API-Schlüssel für externe Dienste (z. B. die Website-API des Projekts) gehören **nicht ins Repository** und werden nie in Dateien eingecheckt.

## GitHub Secret

Der API-Schlüssel der Projekt-Website wird als Repository-Secret unter dem Namen `GD_STORE` geführt. Er ist damit in GitHub-Actions-Workflows verfügbar, ohne im Code oder in der Historie aufzutauchen. Secrets anlegen oder ändern können nur Personen mit Admin-Rechten am Repository unter **Settings → Secrets and variables → Actions → New repository secret**.

Der konkrete Schlüsselwert wird nicht dokumentiert und nicht im Chatverlauf wiederholt.

## Nutzung in Workflows

In einem Workflow wird das Secret über den Workflow-Kontext bereitgestellt und bei Bedarf als Umgebungsvariable weitergereicht. Es erscheint in den Logs nur maskiert.

## Lokale Entwicklung

Für lokale Tests wird der Schlüssel aus einer Datei gelesen, die nicht versioniert wird:

1. Eine Datei `api_key.txt` im Projektstamm anlegen und den Schlüssel als einzigen Inhalt eintragen (die Datei ist in `.gitignore` ausgeschlossen).
2. Beim HTTP-Zugriff kann diese Datei an den `APIClient` aus `addons/plugin_updater/utilities/api_client.gd` übergeben werden (Export-Eigenschaft `api_key_file`); der Client sendet den Inhalt dann als `x-api-key`-Header.

Schlüssel nie in `.gd`-, `.tscn`- oder sonstige Projektdateien schreiben. Falls ein Schlüssel versehentlich veröffentlicht wurde, muss er umgehend auf der Website widerrufen und neu erzeugt werden.
