autoload -U colors && colors

autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit

export HISTFILE=~/.zsh_history
export HISTSIZE=1000000
export SAVEHIST=1000000

setopt HIST_IGNORE_ALL_DUPS     # no duplicates in history
setopt HIST_SAVE_NO_DUPS        # don't save duplicates
setopt HIST_REDUCE_BLANKS       # remove unnecessary blanks
setopt INC_APPEND_HISTORY_TIME  # append command immediately to history
setopt EXTENDED_HISTORY         # record command start time

function source_when_exist() {
  [ -f "$1" ] && source "$1"
}

source_when_exist "$HOME/dotfiles/.aliases"
source_when_exist "$HOME/dotfiles/.functions"
source_when_exist "$HOME/dotfiles/.zsh-prompt"
source_when_exist "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
source_when_exist "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

if hash zoxide 2> /dev/null; then
  eval "$(zoxide init --cmd j bash)"
fi
