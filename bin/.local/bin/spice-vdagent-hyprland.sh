#!/usr/bin/env sh
set -eu

# Avoid duplicate instances (desktop autostart + Hyprland exec-once).
pkill -u "michael" -x spice-vdagent >/dev/null 2>&1 || true
exec /usr/bin/spice-vdagent -x
