autoload -U colors && colors

#autoload -U compinit
#zstyle ':completion:*' menu select
#zmodload zsh/complist
#compinit

setopt HIST_IGNORE_ALL_DUPS     # no duplicates in history
setopt HIST_SAVE_NO_DUPS        # don't save duplicates
setopt HIST_REDUCE_BLANKS       # remove unnecessary blanks
setopt INC_APPEND_HISTORY_TIME  # append command immediately to history
setopt EXTENDED_HISTORY         # record command start time

function source_when_exist() {
  [ -f "$1" ] && source "$1"
}

source_when_exist "$HOME/dotfiles/zsh/.aliases"
source_when_exist "$HOME/dotfiles/zsh/.functions"
source_when_exist "$HOME/dotfiles/zsh/.zsh-prompt"
source_when_exist "$HOME/dotfiles/zsh/.pyenv"
source_when_exist "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
source_when_exist "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source_when_exist "/usr/share/fzf/key-bindings.zsh"
source_when_exist "/usr/share/fzf/completion.zsh"
source_when_exist "$HOME/dotfiles/zsh/init-nvm.sh"

if hash zoxide 2> /dev/null; then
  eval "$(zoxide init --cmd j zsh)"
fi

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/michael/.lmstudio/bin"
