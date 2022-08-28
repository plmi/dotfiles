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

if [ ! -f ~/.zshrc ] && [ -f "${DOTFILES}/.zshrc" ]; then
  ln -s "${DOTFILES}/.zshrc" "${HOME}/.zshrc"
fi

if [ ! -f ~/.config/redshift.conf ] && [ -f "${DOTFILES}/.config/redshift.conf" ]; then
  ln -s "${DOTFILES}/.config/redshift.conf" "${HOME}/.config/redshift.conf"
fi

if [ ! -f ~/.xsession ] && [ -f "${DOTFILES}/.xsession" ]; then
  ln -s "${DOTFILES}/.xsession" "${HOME}/.xsession"
fi

if [ ! -f ~/.antigenrc ] && [ -f "${DOTFILES}/.antigenrc" ]; then
  ln -s "${DOTFILES}/.antigenrc" "${HOME}/.antigenrc"
fi
