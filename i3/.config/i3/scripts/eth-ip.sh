#!/usr/bin/env sh

# Get active ethernet device from NetworkManager
IFACE="$(nmcli -t -f DEVICE,TYPE device status | awk -F: '$2=="ethernet"{print $1; exit}')"

[ -z "$IFACE" ] && { echo "ETH down"; exit; }

ADDR="$(ip -4 -o addr show dev "$IFACE" \
    | awk '{print $4}' | cut -d/ -f1 | head -n1)"

echo "ETH ${ADDR:-no-ip}"
