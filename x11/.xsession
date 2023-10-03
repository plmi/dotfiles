export ANKI_NOHIGHDPI=1
export _JAVA_AWT_WM_NONREPARENTING=1

python3 /home/michael/.local/bin/set_screen.py
set_wallpaper &
redshift &
picom &
dunst &
chromium &
thunderbird &
xrdb -merge /home/michael/.Xresources &
dwmblocks &
exec dwm
