export ANKI_NOHIGHDPI=1
export _JAVA_AWT_WM_NONREPARENTING=1

while true; do
  /home/michael/.local/bin/statusbar.sh
  sleep 1m
done &

python3 /home/michael/.local/bin/set_screen.py
set_wallpaper &
redshift &
picom &
dunst &
chromium &
thunderbird &
exec dwm
