# Unser Familienplan – App-Paket

Eine installierbare Web-App (PWA) für Wochenplan, Rezepte und Einkaufsliste. Ein neuer Wochenplan kann später über **Plan einfügen** aus einem JSON-Plan übernommen werden; bei aktiver Synchronisierung sehen beide Geräte den neuen Stand. Neuinstallation ist dafür nicht nötig. Sie funktioniert zunächst lokal im Browser und offline, sobald sie einmal über HTTPS geöffnet wurde. Für gemeinsame Synchronisierung richtet ihr einmal ein Supabase-Projekt ein und hostet die Dateien über HTTPS.

## Schnell ausprobieren

1. Entpackt das ZIP.
2. Öffnet `index.html` im Browser, um die Inhalte lokal anzusehen. Änderungen bleiben dann nur in diesem Browser.
3. Zum Installieren auf dem Startbildschirm braucht es eine HTTPS-Adresse. `file://` reicht für die Installation nicht.

## Gemeinsame Synchronisierung einrichten

Dafür werden eine HTTPS-Adresse für die App und ein Supabase-Projekt benötigt. Nach der Einrichtung melden sich beide Geräte mit demselben Familienkonto an. Zugangsdaten nicht öffentlich teilen.

1. In Supabase ein Projekt anlegen.
2. Im Supabase SQL Editor den Inhalt aus `supabase-schema.sql` ausführen.
3. In Supabase unter **Project Settings → API** die Project URL und den `anon`/publishable key kopieren.
4. Die App-Dateien auf einen statischen Webhost mit HTTPS hochladen (zum Beispiel GitHub Pages, Netlify oder Cloudflare Pages). Alle Dateien aus diesem Ordner müssen zusammen in den veröffentlichten Ordner.
5. Die veröffentlichte App aufrufen, **Synchronisierung** öffnen, Project URL und Schlüssel eintragen und speichern.
6. Eine Familien-E-Mail und ein starkes Passwort eintragen und **Familienkonto erstellen** wählen. Falls Supabase E-Mail-Bestätigung verlangt, diese erst bestätigen und dann anmelden.
7. Auf dem zweiten Smartphone dieselbe HTTPS-Adresse öffnen, unter **Synchronisierung** dieselben Projektangaben eintragen und mit denselben Familien-Zugangsdaten anmelden.
8. Im Browser **Zum Startbildschirm hinzufügen** / **App installieren** wählen.

Die Project URL und der `anon`-Schlüssel sind für Browser-Apps vorgesehen. Niemals einen `service_role`-Schlüssel in diese App eintragen oder veröffentlichen. Die Datenbankrichtlinien in `supabase-schema.sql` begrenzen den Plan auf das angemeldete Familienkonto.

## Einen neuen Wochenplan übernehmen

Bitte mich künftig um einen Wochenplan im Importformat. Ich kann dann einen JSON-Block mit diesen Feldern erstellen: `weekTitle`, `plan`, `groceries` und `recipes`. Kopiere den JSON-Inhalt ohne die Markdown-Codezaun-Zeilen. In der App **Plan einfügen** wählen, JSON einsetzen und übernehmen. Das ersetzt den aktuellen Wochenplan, setzt die Einkaufs-Häkchen zurück und überträgt die neuen Inhalte bei bestehender Anmeldung in die Cloud. Ältere Wochen werden nicht archiviert.

## Dateien

- `index.html` – Oberfläche und Synchronisierungseinstellungen
- `app.js` – Plan, Rezepte, Einkaufsliste und App-Logik
- `manifest.webmanifest`, `icon.svg`, `sw.js` – Installation und Offline-Grundfunktionen
- `supabase-schema.sql` – Tabelle und Datenbankrichtlinien für die optionale Cloud-Synchronisierung

## Grenzen

- Ohne HTTPS-Hosting kann die App nicht als PWA installiert und nicht geräteübergreifend synchronisiert werden.
- Live-Änderungen werden über Supabase Realtime empfangen. In Supabase muss dafür `family_plan` in der Datenbank-Replikation für Realtime aktiviert sein (Database → Publications/Replication, je nach Oberfläche).
- Wenn beide Geräte denselben Eintrag genau gleichzeitig bearbeiten, gilt die zuletzt gespeicherte Version.
- Für einen ersten Start ist der Einkaufsbetrag von ca. 112 € ein grober Richtwert. Preise, Vorräte und Angebote können ihn verändern.
