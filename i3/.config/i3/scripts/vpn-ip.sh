#!/usr/bin/env sh

VPN_NAME="$(nmcli -t -f NAME,TYPE connection show --active | awk -F: '$2=="vpn"{print $1; exit}')"

[ -z "$VPN_NAME" ] && exit 0

# Find tunnel interface
VPN_IFACE="$(nmcli -t -f DEVICE,TYPE connection show --active | awk -F: '$2=="tun"{print $1; exit}')"

# Fallback if nmcli didn't provide interface
[ -z "$VPN_IFACE" ] && VPN_IFACE="$(ip -o link | awk -F': ' '/tun|tap/ {print $2; exit}')"

VPN_IP="$(ip -4 -o addr show dev "$VPN_IFACE" 2>/dev/null \
    | awk '{print $4}' | cut -d/ -f1 | head -n1)"

echo "VPN ${VPN_IP} ($VPN_NAME)"
