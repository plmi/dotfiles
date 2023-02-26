if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi

path+=('/home/michael/.local/bin')
export PATH
export XDG_CONFIG_HOME="$HOME/.config"
