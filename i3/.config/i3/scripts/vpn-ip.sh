#!/usr/bin/env sh

VPN_IP="$(ip -4 -o addr show dev tun0 2>/dev/null | awk '{print $4}' | cut -d/ -f1 | head -n1)"

[ -z "$VPN_IP" ] && exit 0

echo "VPN ${VPN_IP}"
