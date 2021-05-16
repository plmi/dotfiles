# status bar
while xsetroot -solid black -name "`date +"%d. %b %H:%M"` `uptime | cut -d ' ' -f5 | set 's/,//'`"; do
	sleep 20
done &

# make ghidra work
export _JAVA_AWT_WM_NONREPARENTING=1

redshift &
firefox &
thunderbird &

exec dwm
