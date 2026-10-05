#!/bin/bash

# sys-check.sh
# Ein leichtgewichtiges Skript zur schnellen Systemanalyse.
# Teil des cds DevOps Moduls - Woche 02
# Author: Martina Cavegn

# Farben für die Ausgabe definieren
COLOR_HEADER='\033[1;36m'   # Cyan
COLOR_OK='\033[0;32m'       # Grün
COLOR_WARN='\033[0;33m'     # Gelb
COLOR_RESET='\033[0m'       # Reset

# Funktion für Header
print_header() {
    echo -e "${COLOR_HEADER}----------------------------------------${COLOR_RESET}"
    echo -e "${COLOR_HEADER}  System Health Check - $(hostname)${COLOR_RESET}"
    echo -e "${COLOR_HEADER}----------------------------------------${COLOR_RESET}"
    echo ""
}

# 1. Systeminfo (Kernel & Uptime)
print_system_info() {
    echo -e "${COLOR_HEADER}>> System Informationen${COLOR_RESET}"
    
    if command -v uname &> /dev/null; then
        echo "  Kernel: $(uname -r)"
        echo "  OS:     $(uname -o)"
    else
        echo -e "${COLOR_WARN}  [!] Befehl 'uname' nicht gefunden${COLOR_RESET}"
    fi

    if command -v uptime &> /dev/null; then
        # uptime nur kurz anzeigen (seit wann läuft das System)
        echo "  Uptime: $(uptime -p 2>/dev/null || uptime | awk -F, '{print $1,$2}' | sed 's/ up //')"
    fi
    echo ""
}

# 2. Speichernutzung (Disk)
print_disk_usage() {
    echo -e "${COLOR_HEADER}>> Speichernutzung (Dateisystem)${COLOR_RESET}"
    
    if command -v df &> /dev/null; then
        # Zeige nur die Root-Partition und human-readable Format
        df -h / | tail -n +2 | awk '{printf "  Total: %s | Used: %s | Free: %s | Usage: %s\n", $2, $3, $4, $5}'
    else
        echo -e "${COLOR_WARN}  [!] Befehl 'df' nicht gefunden${COLOR_RESET}"
    fi
    echo ""
}

# 3. RAM Nutzung
print_ram_usage() {
    echo -e "${COLOR_HEADER}>> Arbeitsspeicher (RAM)${COLOR_RESET}"

    if command -v free &> /dev/null; then
        # Hole Werte in MB
        mem_info=$(free -m | grep Mem)
        total=$(echo $mem_info | awk '{print $2}')
        used=$(echo $mem_info | awk '{print $3}')
        free_mem=$(echo $mem_info | awk '{print $4}')
        
        echo "  Total: ${total} MB"
        echo "  Used:  ${used} MB"
        echo "  Free:  ${free_mem} MB"
    else
        echo -e "${COLOR_WARN}  [!] Befehl 'free' nicht gefunden${COLOR_RESET}"
    fi
    echo ""
}

# 4. Netzwerk Check
print_network_check() {
    echo -e "${COLOR_HEADER}>> Netzwerk Konnektivität${COLOR_RESET}"
    
    target="8.8.8.8"
    if command -v ping &> /dev/null; then
        # Ping nur 2 Pakete, Timeout 2 Sekunden
        if ping -c 2 -W 2 "$target" > /dev/null 2>&1; then
            echo -e "  Status: ${COLOR_OK}ONLINE${COLOR_RESET} (Ziel: $target erreichbar)"
        else
            echo -e "  Status: ${COLOR_WARN}OFFLINE${COLOR_RESET} (Keine Verbindung zu $target)"
        fi
    else
        echo -e "${COLOR_WARN}  [!] Befehl 'ping' nicht gefunden${COLOR_RESET}"
    fi
    echo ""
}

# Hauptausführung
main() {
    print_header
    print_system_info
    print_disk_usage
    print_ram_usage
    print_network_check
    
    echo -e "${COLOR_HEADER}----------------------------------------${COLOR_RESET}"
    echo -e "Check abgeschlossen um $(date '+%H:%M:%S')"
    echo -e "${COLOR_HEADER}----------------------------------------${COLOR_RESET}"
}

# Skript starten
main

