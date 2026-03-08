#!/usr/bin/env bash

# Get VPN profiles
mapfile -t vpns < <(nmcli -t -f NAME,TYPE connection show | awk -F: '$2=="vpn"{print $1}')

# Detect active VPN
active_vpn=$(nmcli -t -f NAME,TYPE connection show --active | awk -F: '$2=="vpn"{print $1}')

menu=()

for vpn in "${vpns[@]}"; do
    if [[ "$vpn" == "$active_vpn" ]]; then
        menu+=("● $vpn (connected)")
    else
        menu+=("○ $vpn")
    fi
done

choice=$(printf '%s\n' "${menu[@]}" | rofi -dmenu -i -p "🔒 VPN")

[[ -z "$choice" ]] && exit 0

vpn=$(echo "$choice" | sed -E 's/^[●○] ([^ ]+).*/\1/')

# Case 1: user selected the currently connected VPN → disconnect
if [[ "$vpn" == "$active_vpn" ]]; then
    if nmcli connection down "$vpn"; then
        notify-send -r 9991 "VPN Disconnected" "$vpn"
    else
        notify-send -u critical -t 10000 "VPN Error" "Failed to disconnect $vpn"
    fi
    exit
fi

# Case 2: switching VPNs → disconnect old one first
if [[ -n "$active_vpn" ]]; then
    if ! nmcli connection down "$active_vpn"; then
        notify-send -u critical -t 10000 "VPN Error" "Failed to disconnect $active_vpn"
        exit
    fi
fi

# Connect new VPN
if nmcli connection up "$vpn"; then
    notify-send -r 9991 "VPN Connected" "$vpn"
else
    notify-send -u critical -t 10000 "VPN Error" "Failed to connect $vpn"
fi
