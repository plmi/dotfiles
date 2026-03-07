#!/usr/bin/env sh
# Battery status - mirrors waybar battery module
WARNING=25
CRITICAL=12

BAT_PATH="$(find /sys/class/power_supply -maxdepth 1 -name 'BAT*' | head -n1)"

if [ -z "$BAT_PATH" ]; then
    echo "AC"
    exit 0
fi

CAP="$(cat "$BAT_PATH/capacity" 2>/dev/null || echo '?')"
STATUS="$(cat "$BAT_PATH/status" 2>/dev/null || echo 'Unknown')"

case "$STATUS" in
    Charging)  echo "CHR ${CAP}%" ;;
    Full)      echo "AC ${CAP}%" ;;
    *)
        if [ "$CAP" != '?' ] && [ "$CAP" -le "$CRITICAL" ]; then
            echo "LOW ${CAP}%"
        else
            echo "BAT ${CAP}%"
        fi
        ;;
esac
