if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi

path+=('/home/michael/.local/bin')

# Created by `pipx` on 2024-11-13 22:39:21
if [[ "$OSTYPE" == "darwin"* ]]; then
  path+=('/Users/michael/.local/bin')
fi

export PATH
export XDG_CONFIG_HOME="$HOME/.config"
