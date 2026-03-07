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
export XDG_CONFIG_HOME="$HOME/.config"
# Scale Burp on i3
export _JAVA_OPTIONS="-Dsun.java2d.uiScale=2.0
