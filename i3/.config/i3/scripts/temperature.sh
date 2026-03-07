#!/usr/bin/env sh
# CPU temperature - mirrors waybar temperature module
CRITICAL=85

TEMP=""
# Try hwmon first (most reliable)
for f in /sys/class/hwmon/hwmon*/temp*_input; do
    [ -f "$f" ] || continue
    TEMP="$(cat "$f")"
    break
done

# Fallback to thermal_zone
if [ -z "$TEMP" ]; then
    for f in /sys/class/thermal/thermal_zone*/temp; do
        [ -f "$f" ] || continue
        TEMP="$(cat "$f")"
        break
    done
fi

if [ -z "$TEMP" ]; then
    echo "TMP N/A"
    exit 0
fi

CELSIUS="$(( TEMP / 1000 ))"

if [ "$CELSIUS" -ge "$CRITICAL" ]; then
    echo "HOT ${CELSIUS}C"
else
    echo "TMP ${CELSIUS}C"
fi
