#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle Technobase Radio
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🎵
# @raycast.packageName Radio

STREAM_URL="http://listen.technobase.fm/listen.mp3.m3u"
MPV_BIN="${MPV_BIN:-mpv}"

if pgrep -f "$MPV_BIN.*$STREAM_URL" > /dev/null || pgrep -f "mpv.*$STREAM_URL" > /dev/null; then
  pkill -f "$MPV_BIN.*$STREAM_URL" || pkill -f "mpv.*$STREAM_URL"
else
  "$MPV_BIN" --volume=25 "$STREAM_URL" > /dev/null 2>&1 &
fi
