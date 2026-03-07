#!/usr/bin/env sh
# Network status - mirrors waybar network module

# Prefer the default route interface
IFACE="$(ip route show default 2>/dev/null | awk '/default/ {print $5; exit}')"

if [ -z "$IFACE" ]; then
    echo "NET down"
    exit 0
fi

# Check if wireless
if [ -d "/sys/class/net/$IFACE/wireless" ]; then
    ESSID="$(iwgetid -r "$IFACE" 2>/dev/null || echo '?')"
    QUALITY="$(awk "/$IFACE/ {gsub(/\./, \"\"); printf \"%d\", \$3 * 100 / 70}" /proc/net/wireless 2>/dev/null || echo '?')"
    echo "WIFI $ESSID ${QUALITY}%"
else
    ADDR="$(ip -4 -o addr show dev "$IFACE" 2>/dev/null | awk '{print $4}' | cut -d/ -f1 | head -n1)"
    echo "ETH ${ADDR:-no-ip}"
fi
