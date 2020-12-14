#!/usr/bin/env bash

# fix permission problem on mojave: https://stackoverflow.com/a/61011665
# activate shell completion
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi

if [ -f "./.aliases" ]; then
	. "${DOTFILES}/.aliases"
fi

if [ -f "./.functions" ]; then
	. "${DOTFILES}/.functions"
fi

if [ -f "./.zsh-prompt" ]; then
	. "./.zsh-prompt"
fi

if [ -d "$HOME/.bin" ]; then
  export PATH="$PATH:~/.bin"
fi

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

if command -v go 1>/dev/null 2>&1; then
  export GOPATH=$HOME/go
  export PATH="$PATH:/$GOPATH/bin"
fi

if command -v bat 1>/dev/null 2>&1; then
  # colored man pages
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

if command -v jenv 1>/dev/null 2>&1; then
  export PATH="$HOME/.jenv/bin:$PATH"
  eval "$(jenv init -)"
fi

if command -v nvm 1>/dev/null 2>&1; then
  export NVM_DIR="$HOME/.nvm" 
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  
fi
