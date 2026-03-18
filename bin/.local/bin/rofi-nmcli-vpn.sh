#!/usr/bin/env bash

set -euo pipefail

OVPN_DIR="$HOME/.config/vpn/openvpn"
PIDFILE="/tmp/openvpn-rofi.pid"
NAMEFILE="/tmp/openvpn-rofi.name"
LOGFILE="/tmp/openvpn-rofi.log"
MGMT_SOCKET="/tmp/openvpn-rofi.sock"

CONNECT_TIMEOUT=30  # seconds to wait for connection
KILL_TIMEOUT=10     # seconds to wait for process to die

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

# Check if openvpn is actually running (guards against stale PID files and
# recycled PIDs by verifying the process is indeed openvpn).
is_vpn_running() {
    local pid
    pid=$(cat "$PIDFILE" 2>/dev/null) || return 1
    [[ -n "$pid" ]] || return 1
    # Process exists AND is openvpn (not a recycled PID)
    sudo kill -0 "$pid" 2>/dev/null || return 1
    grep -q 'openvpn' "/proc/$pid/comm" 2>/dev/null
}

get_active_vpn() {
    if is_vpn_running; then
        cat "$NAMEFILE" 2>/dev/null
    else
        # Stale files — clean up
        cleanup_files
    fi
}

cleanup_files() {
    rm -f "$PIDFILE" "$NAMEFILE" "$LOGFILE" "$MGMT_SOCKET"
}

# Reliable disconnect: signal via management socket first, fall back to
# SIGTERM, then wait for the process to actually exit.
disconnect_vpn() {
    local pid
    pid=$(cat "$PIDFILE" 2>/dev/null) || { cleanup_files; return 0; }
    [[ -n "$pid" ]] || { cleanup_files; return 0; }

    # 1) Try graceful shutdown via management socket
    if [[ -S "$MGMT_SOCKET" ]]; then
        echo "signal SIGTERM" | sudo socat - "UNIX-CONNECT:$MGMT_SOCKET" 2>/dev/null || true
    fi

    # 2) If still alive, send SIGTERM directly
    if sudo kill -0 "$pid" 2>/dev/null; then
        sudo kill "$pid" 2>/dev/null || true
    fi

    # 3) Wait for the process to actually exit (critical for clean session
    #    teardown on the server side — avoids "multiple instances" warnings).
    local elapsed=0
    while sudo kill -0 "$pid" 2>/dev/null && (( elapsed < KILL_TIMEOUT )); do
        sleep 1
        (( elapsed++ ))
    done

    # 4) Last resort: SIGKILL
    if sudo kill -0 "$pid" 2>/dev/null; then
        sudo kill -9 "$pid" 2>/dev/null || true
        sleep 1
    fi

    cleanup_files
}

# Wait for the tunnel interface (tun/tap) to come up.  This is the most
# reliable, config-agnostic signal that OpenVPN has established the data-plane
# connection.  Falls back to log-file parsing as a secondary indicator.
wait_for_connection() {
    local elapsed=0

    while (( elapsed < CONNECT_TIMEOUT )); do
        # Primary check: a tun or tap device exists that wasn't there before
        if ip link show type tun 2>/dev/null | grep -q 'state UP\|state UNKNOWN'; then
            return 0
        fi

        # Secondary check: log file reports success (single occurrence is fine)
        if grep -q "Initialization Sequence Completed" "$LOGFILE" 2>/dev/null; then
            return 0
        fi

        # Bail early if the process died
        if ! is_vpn_running; then
            return 1
        fi

        sleep 1
        (( elapsed++ ))
    done

    return 1
}

# ---------------------------------------------------------------------------
# Gather profiles
# ---------------------------------------------------------------------------
mapfile -t ovpn_files < <(find "$OVPN_DIR" -maxdepth 1 -name "*.ovpn" | sort)

if [[ ${#ovpn_files[@]} -eq 0 ]]; then
    notify-send -u critical "VPN Error" "No .ovpn profiles found in $OVPN_DIR"
    exit 1
fi

active_vpn=$(get_active_vpn)

# ---------------------------------------------------------------------------
# Build Rofi menu
# ---------------------------------------------------------------------------
menu=()
for f in "${ovpn_files[@]}"; do
    name=$(basename "$f" .ovpn)
    if [[ "$name" == "$active_vpn" ]]; then
        menu+=("● $name (connected)")
    else
        menu+=("○ $name")
    fi
done

choice=$(printf '%s\n' "${menu[@]}" | rofi -dmenu -i -p "🔒 VPN")
[[ -z "$choice" ]] && exit 0

vpn=$(echo "$choice" | sed -E 's/^[●○] //; s/ \(connected\)$//')
profile="$OVPN_DIR/$vpn.ovpn"

if [[ ! -f "$profile" ]]; then
    notify-send -u critical "VPN Error" "Profile not found: $profile"
    exit 1
fi

# ---------------------------------------------------------------------------
# Disconnect if selecting the active VPN
# ---------------------------------------------------------------------------
if [[ "$vpn" == "$active_vpn" ]]; then
    disconnect_vpn
    notify-send -r 9991 "VPN Disconnected" "$vpn"
    exit 0
fi

# ---------------------------------------------------------------------------
# Switch: disconnect old VPN first (and wait for full teardown)
# ---------------------------------------------------------------------------
if [[ -n "$active_vpn" ]]; then
    disconnect_vpn
    # Small grace period so the server registers the session as closed
    sleep 2
fi

# ---------------------------------------------------------------------------
# Connect
# ---------------------------------------------------------------------------
# Truncate log so we only watch fresh output
: > "$LOGFILE"

sudo openvpn --config "$profile" \
             --cd "$OVPN_DIR" \
             --daemon \
             --writepid "$PIDFILE" \
             --log "$LOGFILE" \
             --management "$MGMT_SOCKET" unix

echo "$vpn" > "$NAMEFILE"

if wait_for_connection; then
    notify-send -r 9991 "VPN Connected" "$vpn"
else
    # Connection failed — tear down whatever is left
    disconnect_vpn
    notify-send -u critical -t 10000 "VPN Error" \
        "Failed to connect to $vpn — check $LOGFILE"
    exit 1
fi
