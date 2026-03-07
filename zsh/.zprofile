if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi

path+=("${HOME}/.local/bin")
path+=("${HOME}/.antigravity/antigravity/bin")

# Created by `pipx` on 2024-11-13 22:39:21
if [[ "$OSTYPE" == "darwin"* ]]; then
  path+=('/Users/michael/.local/bin')
fi

export PATH

# anki
export _JAVA_AWT_WM_NONREPARENTING=1
export ANKI_NOHIGHDPI=1
export DISABLE_QT5_COMPAT=1

# brew
export HOMEBREW_NO_ANALYTICS=1

# GUI scaling (burp, sqlitebrowser)
export GDK_SCALE=2
export QT_SCALE_FACTOR=2
export QT_AUTO_SCREEN_SCALE_FACTOR=1

# Scale Burp on i3
export _JAVA_OPTIONS="-Dsun.java2d.uiScale=2.0"
