export EDITOR="$(which nvim)"
export DOTFILES="$HOME/dotfiles"

# path
path+=("$DOTFILES/bin/.local/bin")
export PATH

# zsh
export HISTFILE=~/.zsh_history
export HISTSIZE=1000000
export SAVEHIST=1000000

# pass
export PASSWORD_STORE_DIR="${HOME}/.password-store"

# anki
export _JAVA_AWT_WM_NONREPARENTING=1
export ANKI_NOHIGHDPI=1
export DISABLE_QT5_COMPAT=1

# colored man pages
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"

# bat
export BAT_THEME="Catppuccin-mocha"

# fzf
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
