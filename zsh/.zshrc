autoload -U colors && colors

#autoload -U compinit
#zstyle ':completion:*' menu select
#zmodload zsh/complist
#compinit

export HISTSIZE=1000000                 # Set the amount of lines you want saved
export SAVEHIST=1000000                 # Required to actually save them, needs to match HISTSIZE
export HISTFILE="${HOME}/.zsh_history"  # Save them on this file

setopt HIST_IGNORE_ALL_DUPS     # No duplicates in history
setopt HIST_SAVE_NO_DUPS        # Don't save duplicates
setopt HIST_REDUCE_BLANKS       # Remove unnecessary blanks
setopt INC_APPEND_HISTORY_TIME  # Append command immediately to history
setopt EXTENDED_HISTORY         # Record command start time
setopt SHARE_HISTORY            # Share history between all sessions
setopt HIST_IGNORE_SPACE        # Don't record an entry starting with a space
PROMPT_COMMAND="history -a;history -c;history -r; $PROMPT_COMMAND"

function source_when_exist() {
  # shellcheck disable=SC1090
  [ -f "$1" ] && source "$1"
}

source_when_exist "$HOME/dotfiles/zsh/.aliases"
source_when_exist "$HOME/dotfiles/zsh/.functions"
source_when_exist "$HOME/dotfiles/zsh/.zsh-prompt"
source_when_exist "$HOME/dotfiles/zsh/.pyenv"
source_when_exist "/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source_when_exist "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
if hash brew >/dev/null 2>&1; then
  source_when_exist "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi
source_when_exist "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source_when_exist "/usr/share/fzf/key-bindings.zsh"
source_when_exist "/usr/share/fzf/completion.zsh"
# shellcheck disable=SC1090
source <(fzf --zsh)
source_when_exist "$HOME/dotfiles/zsh/init-nvm.sh"

# https://stackoverflow.com/a/43087047
bindkey -e

bindkey '^ ' autosuggest-accept  # ctrl + space
bindkey '^N' autosuggest-execute # ctrl + N

if hash zoxide 2> /dev/null; then
  eval "$(zoxide init --cmd j zsh)"
fi

