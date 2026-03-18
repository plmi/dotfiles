export EDITOR="$(which nvim)"
export DOTFILES="$HOME/dotfiles"
export XDG_CONFIG_HOME="$HOME/.config"


# zsh
export HISTFILE=~/.zsh_history
export HISTSIZE=1000000
export SAVEHIST=1000000

# pass
export PASSWORD_STORE_DIR="${HOME}/.password-store"

# colored man pages
if command -v bat &>/dev/null; then
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
  export MANROFFOPT="-c"
  export BAT_THEME="Catppuccin-mocha"
fi

# fzf
#export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git" 2> /dev/null'
#export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
