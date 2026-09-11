# Inhalte pflegen

Die Website bleibt bei GitHub Pages und Markdown. Für Updates genügt es, die betreffende Datei zu bearbeiten und wie bisher über GitHub zu veröffentlichen. Die Seiten selbst müssen dabei nicht angepasst werden.

## Wo ändere ich was?

| Inhalt | Dateien | Erscheint auf |
| --- | --- | --- |
| Publikationen | `_publications/*.md` | Publications und Overview |
| Lehre | `_teaching/*.md` | Teaching und Overview |
| Vorträge | `_talks/*.md` | Talks und Overview |
| Konferenzteilnahmen | `_conferences/*.md` | Talks; direkter Link aus Overview |
| Startseitentext | `_pages/about.md` | Startseite |
| Ausbildung, Computational project | `_pages/bio.md` | CV |
| Outreach | `_data/outreach.yml` | Ausführliche Fassung auf der Startseite, kurze Fassung im CV |
| Porträt, Kontakt und Kurzprofil | `_config.yml`, Abschnitt `author` | Seitenleiste |

## Die häufigsten Updates

### Ein Paper wurde angenommen oder veröffentlicht

In derselben Datei `status: preprint` auf `status: accepted` oder `status: published` ändern. `journal` ergänzen; bei Veröffentlichung zusätzlich `doi` und, falls bekannt, `published_date` eintragen:

```yaml
status: published
journal: "Journal name"
doi: "10.xxxx/xxxxx"
published_date: 2027-06-15
```

Die Gruppenüberschrift und Statusanzeige werden auf beiden Seiten automatisch aktualisiert. DOI nur als Kennung eingeben, ohne URL-Präfix. `arxiv_url` und `arxiv_date` bleiben erhalten. Innerhalb jeder Statusgruppe stehen zuerst alle Paper ohne `order`, nach `arxiv_date` sortiert (neueste zuerst). Darunter folgen alle Paper mit `order`, größere Zahlen zuerst. Ein Statuswechsel verschiebt das Paper in die entsprechende Gruppe, wo dieselbe Regel gilt. `published_date` verändert die Sortierung nicht.

Die vorhandenen Paper wurden bei der technischen Umstellung weiterhin als `preprint` übernommen. Ihre tatsächlichen neuen Status müssen noch manuell eingetragen werden.

### Einen Lehreintrag aktualisieren

`start_year` und `end_year` enthalten Jahreszahlen. `end_year: null` bedeutet laufend und wird als `present` angezeigt. Der Zeitraum erscheint auf Teaching und Overview. Ohne `order` wird nach `start_year` sortiert, neueste zuerst. Einträge mit `order` folgen darunter, größere Zahlen zuerst.

- `title`: Überschrift auf beiden Seiten.
- `type`, `venue`: Art und Institution auf Teaching.
- `summary`: optionale Kurzbeschreibung auf Overview.
- Text unter dem zweiten `---`: ausführliche Beschreibung auf Teaching, einschließlich Listen.
- `overview_title`: optionale abweichende Überschrift nur für Overview. Dieses Feld erhält eine bereits zuvor vorhandene Formulierung; für neue Einträge ist es normalerweise nicht nötig.

Die bestehenden `location`-Angaben wurden erhalten, werden aber weiterhin nicht angezeigt.

### Einen Vortrag oder eine Konferenz aktualisieren

Vorträge verwenden `date`, Konferenzen `start_date` und optional `end_date`, jeweils als `YYYY-MM-DD`. Ohne `order` stehen neuere Einträge zuerst (Vorträge nach `date`, Konferenzen nach `start_date`). Einträge mit `order` folgen darunter, größere Zahlen zuerst. `title`, `type` und `venue` werden direkt angezeigt; `remote: true` ergänzt den vorhandenen Remote-Hinweis. `link` verlinkt den Titel. Bei Vorträgen erscheint Text unter dem zweiten `---` auf Talks. Konferenzen haben nur eine kompakte Ansicht ohne ausführlichen Text.

## Neue Einträge

Eine passende Datei aus `content-templates/` in den jeweiligen Inhaltsordner kopieren, sinnvoll benennen und die Beispielangaben ersetzen. Die Vorlagen selbst werden nicht veröffentlicht. Die bisherige Reihenfolge wurde durch `order` bei den bestehenden Einträgen erhalten. Bei neuen Einträgen `order` einfach weglassen: Sie erscheinen oberhalb der manuell sortierten Einträge, untereinander nach Datum (neueste zuerst). Mit `order` lässt sich ein Eintrag in den unteren, manuell sortierten Teil aufnehmen: größere Zahlen stehen dort weiter oben. Zum Umordnen die Zahlen tauschen oder neu vergeben; jede Zahl soll pro Ordner nur einmal vorkommen. Bei Publikationen gilt diese Regel innerhalb jeder Statusgruppe. Der Dateiname bestimmt nicht die Sortierung. Ein zusätzliches `collection`-Feld ist nicht nötig: Der Ordner legt den Typ fest.

## Format und optionale Felder

Zwischen den beiden `---` stehen die strukturierten Angaben (YAML), darunter normaler Markdown-Text. Titel und andere Texte mit Doppelpunkten in Anführungszeichen setzen. Einzeilige Texte können in doppelte Anführungszeichen; für mathematische Formeln und längere Abstracts eignet sich ein eingerückter Textblock:

```yaml
abstract: >-
  First line of the abstract.
  The next line continues the same paragraph; $$\mathfrak{gl}_N$$ is supported.
```

Bei diesem Format werden Zeilen innerhalb eines Absatzes mit Leerzeichen verbunden. Der bestehende Wortlaut kann also beim Umbrechen unverändert bleiben.

Optionale Felder weglassen oder als Kommentar mit `#` stehen lassen, statt leere Werte oder Platzhalter einzutragen. Pflichtangaben stehen in den Vorlagen ohne Kommentar. Bei Publikationen sind Titel, Status und erstes arXiv-Datum erforderlich; ein arXiv-Link ist optional.

Folgende optionalen Links werden unabhängig voneinander angezeigt: `arxiv_url`, `doi`, `paper_url`, `slides_url`, `bibtex_url`, `database_url`. Datei-Links können externe HTTPS-Adressen oder mit `/` beginnende Pfade innerhalb der Website sein. Ein optionales Publikationsbild verwendet `image`, relativ zu `images/`, und optional `image_alt`. Ohne Bildfeld wird kein Bild eingebunden.

Bestehende Zusatztexte (etwa Koautoren und der Datenbank-Link) bleiben im Markdown-Text. Ein zusätzliches `database_url` ist nur sinnvoll, wenn ein separater Link gewünscht ist; es muss nicht parallel gepflegt werden.

## Prüfung vor dem Veröffentlichen

Optional im Projektordner ausführen:

```sh
ruby scripts/check-content.rb
```

Die Prüfung benötigt nur Ruby und meldet fehlerhafte Pflichtfelder, Statuswerte, Datumsangaben und Links mit Dateinamen. Sie ändert keine Dateien. Anschließend kann mit einer eingerichteten Projektumgebung die Website wie bisher gebaut werden:

```sh
bundle exec jekyll build
```

## Hinweise zur technischen Umstellung

- Publikationen: `category` → `status`, `arxivdate` → `arxiv_date`, `arxivurl` → `arxiv_url`, `excerpt` → `abstract`.
- Lehre: `time` → `start_year`/`end_year`, `details` → `summary`, die vorhandene separate `description` → `overview_title`.
- Konferenzen: `startdate`/`enddate` → `start_date`/`end_date`.
- Gemeinsame Vorlagen in `_includes/` erzeugen die Kurz- und Langansichten; Gestaltung liegt in `assets/css/main.scss`.

Forschungsprofil, Jobsuchhinweis und redaktionelle Textkorrekturen sind nicht Teil dieser technischen Umstellung.
