typeset -U path

# TTY fallback: auto-start X on virtual console 1 if no display manager is running.
# Dead code when using SDDM — $DISPLAY is already set so this block never executes.
if [[ "$OSTYPE" == linux* ]] && [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi

path+=("$DOTFILES/bin/.local/bin")
path+=("$HOME/.dotnet/tools")
path+=("$HOME/.cargo/bin")
path+=("${HOME}/.local/bin")
path+=("${HOME}/.antigravity/antigravity/bin")
export PATH

if [[ "$OSTYPE" == "darwin"* ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  # Added by OrbStack: command-line tools and integration
  source ~/.orbstack/shell/init.zsh 2>/dev/null || :
fi

# brew
export HOMEBREW_NO_ANALYTICS=1

# burp-suite
export _JAVA_OPTIONS="-Dsun.java2d.uiScale=2.0"
