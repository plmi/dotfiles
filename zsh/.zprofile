# TTY fallback: auto-start X on virtual console 1 if no display manager is running.
# Dead code when using SDDM — $DISPLAY is already set so this block never executes.
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi

path+=("$DOTFILES/bin/.local/bin")
path+=("$HOME/.dotnet/")
path+=("$HOME/.cargo/bin")
path+=("${HOME}/.local/bin")
path+=("${HOME}/.antigravity/antigravity/bin")

# Created by `pipx` on 2024-11-13 22:39:21
if [[ "$OSTYPE" == "darwin"* ]]; then
  path+=('/Users/michael/.local/bin')
fi
export PATH

# brew
export HOMEBREW_NO_ANALYTICS=1
