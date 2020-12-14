#!/bin/bash

DOTFILES="${HOME}/dotfiles"

if [ ! -d ~/.vim ] && [ ! -f ~/.vim/vimrc ] && [ -f "${DOTFILES}/vimrc" ]; then
  mkdir ~/.vim
  ln -s "${DOTFILES}/vimrc" "${HOME}/.vim/vimrc"
fi

if [ ! -f ~/.tmux.conf ] && [ -f "${DOTFILES}/.tmux.conf" ]; then
  ln -s "${DOTFILES}/.tmux.conf" "${HOME}/.tmux.conf"
fi

if [ ! -f ~/.gitconfig ] && [ -f "${DOTFILES}/.gitconfig" ]; then
  ln -s "${DOTFILES}/.gitconfig" "${HOME}/.gitconfig"
fi
