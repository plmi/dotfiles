#!/usr/bin/env sh
# Volume status - mirrors waybar pulseaudio module
# Send signal 10 to i3blocks PID to refresh: pkill -SIGRTMIN+10 i3blocks

# Handle scroll events from i3blocks
case "${BLOCK_BUTTON:-}" in
    4) wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+ ;;  # scroll up
    5) wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%- ;;  # scroll down
    1) pavucontrol & ;;                               # left click
esac

MUTED="$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null | grep -c MUTED || true)"
VOL="$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null | awk '{printf "%d", $2 * 100}')"

if [ "$MUTED" -gt 0 ]; then
    echo "MUTED"
else
    echo "VOL ${VOL}%"
fi
