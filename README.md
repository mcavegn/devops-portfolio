# cds DevOps Uebung Woche 02 git-gihub
Bestandteil vom cds-Modul DevOps

Kurzbeschreibung in einem Satz: Ein Bash-Skript zur automatisierten Systemdiagnose für Administratoren, das Uptime, Speicher und Dateisysteme in Sekunden analysiert.

## Voraussetzungen

- Bash Shell (Linux oder macOS)
- Standard Unix-Befehle (uname, uptime, df, free)

## Installation

```bash
git clone git@github.com:<GITHUB_USER>/[projekt].git
cd [projekt]
chmod +x sys-check.sh
```

## Nutzung

```
./sys-check.sh
```
Der Befehl startet die Analyse und gibt eine formatierte Übersicht des aktuellen Systemzustands (Kernel, Laufzeit, Speicherbedarf) direkt im Terminal aus.

## Projektstruktur

```
[projekt]/
├── README.md
├── .gitignore
├── LICENSE
└── sys-check.sh      [Hauptskript]
```

## Lizenz

Veröffentlicht unter der MIT-Lizenz (Datei `LICENSE` im Projekt-Repository).
