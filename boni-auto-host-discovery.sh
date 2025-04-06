#!/bin/bash

# Boni Auto Host Discovery Tool
# Author: Boni Yeamin
# Date: 2025-04-06
# Contact: boniyeamincse

# ─── Banner ─────────────────────────────────────────
echo "=============================================="
echo "      🔍 Boni Auto Host Discovery Tool        "
echo "=============================================="
echo "__________              .__     _____          __           __________                             "
echo "\______   \ ____   ____ |__|   /  _  \  __ ___/  |_  ____   \______   \ ____   ____  ____   ____  "
echo " |    |  _//  _ \ /    \|  |  /  /_\  \|  |  \   __\/  _ \   |       _// __ \_/ ___\/  _ \ /    \ "
echo " |    |   (  <_> )   |  \  | /    |    \  |  /|  | (  <_> )  |    |   \  ___/\  \__(  <_> )   |  \\"
echo " |______  /\____/|___|  /__| \____|__  /____/ |__|  \____/   |____|_  /\___  >\___  >____/|___|  /"
echo "        \/            \/             \/                             \/     \/     \/           \/ "
echo ""
echo "Author: Boni Yeamin"
echo ""

# ─── Check and Install Nmap ────────────────────────
if ! command -v nmap &> /dev/null; then
    echo "[+] Nmap not found. Installing..."
    sudo apt update && sudo apt install -y nmap
else
    echo "[+] Nmap is already installed."
fi

# ─── User Input for IP Block ───────────────────────
read -rp "Enter the IP block (e.g. 192.168.1.0/24): " IP_BLOCK
BLOCK_DIR=$(echo "$IP_BLOCK" | tr '/' '_')
mkdir -p "$BLOCK_DIR"

echo "[*] Scanning network: $IP_BLOCK..."
LIVE_HOSTS_FILE="$BLOCK_DIR/all_live_hosts.txt"
SUMMARY_FILE="$BLOCK_DIR/ip_summary.txt"
> "$LIVE_HOSTS_FILE"
> "$SUMMARY_FILE"

# ─── Host Discovery ────────────────────────────────
echo "[*] Running Nmap ping scan to find live hosts..."
nmap -sn "$IP_BLOCK" -oG - | awk '/Up$/{print $2}' > "$LIVE_HOSTS_FILE"
LIVE_COUNT=$(wc -l < "$LIVE_HOSTS_FILE")
TOTAL_IPS=$(nmap -sL "$IP_BLOCK" | grep "Nmap scan report" | wc -l)

# ─── Port Scan Each Live IP ────────────────────────
echo "[*] Scanning open ports on live hosts..."
while read -r IP; do
    echo "  └─ Scanning $IP"
    nmap -sS "$IP" -Pn -oN "$BLOCK_DIR/${IP}_ports.txt" > /dev/null
done < "$LIVE_HOSTS_FILE"

# ─── Create Summary ────────────────────────────────
{
    echo "Network Block       : $IP_BLOCK"
    echo "Total Hosts in Block: $TOTAL_IPS"
    echo "Total Live Hosts    : $LIVE_COUNT"
    echo "Scan Date           : $(date)"
} > "$SUMMARY_FILE"

# ─── Done ──────────────────────────────────────────
echo ""
echo "✅ Scan complete!"
echo "📂 Results saved in folder: $BLOCK_DIR"
echo "   ├── all_live_hosts.txt"
echo "   ├── IP-wise port results (e.g., 192.168.1.1_ports.txt)"
echo "   └── ip_summary.txt"
echo ""
