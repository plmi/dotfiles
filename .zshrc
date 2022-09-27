# Created by newuser for 5.8
source $HOME/antigen.zsh
antigen init ~/.antigenrc

export HISTFILE=~/.zsh_history
export HISTSIZE=1000000   # the number of items for the internal history list
export SAVEHIST=1000000   # maximum number of items for the history file

# The meaning of these options can be found in man page of `zshoptions`.
setopt HIST_IGNORE_ALL_DUPS  # do not put duplicated command into history list
setopt HIST_SAVE_NO_DUPS  # do not save duplicated command
setopt HIST_REDUCE_BLANKS  # remove unnecessary blanks
setopt INC_APPEND_HISTORY_TIME  # append command to history file immediately after execution
setopt EXTENDED_HISTORY  # record command start time

if [ -f "$HOME/dotfiles/.zsh-prompt" ]; then
  . "$HOME/dotfiles/.zsh-prompt"
fi

if [ -f "$HOME/dotfiles/.functions" ]; then
  . "$HOME/dotfiles/.functions"
fi

if [ -f "$HOME/dotfiles/.aliases" ]; then
  . "$HOME/dotfiles/.aliases"
fi

# setup pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
#eval "$(pyenv virtualenv-init -)"

[[ -s /home/michael/.autojump/etc/profile.d/autojump.sh ]] \
  && source /home/michael/.autojump/etc/profile.d/autojump.sh

#autoload -U compinit && compinit -u
