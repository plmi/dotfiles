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

if [ ! -f ~/.zprofile ] && [ -f "${DOTFILES}/.zprofile" ]; then
  ln -s "${DOTFILES}/.zprofile" "${HOME}/.zprofile"
fi

if [ ! -f ~/.xinitrc ] && [ -f "${DOTFILES}/.xinitrc" ]; then
  ln -s "${DOTFILES}/.xinitrc" "${HOME}/.xinitrc"
fi

if [ ! -f ~/.antigenrc ] && [ -f "${DOTFILES}/.antigenrc" ]; then
  ln -s "${DOTFILES}/.antigenrc" "${HOME}/.antigenrc"
fi

if [ ! -f "${HOME}/.local/share/wallpapers" ] && [ -f "${DOTFILES}/wallpapers" ]; then
  mkdir -p "${HOME}/.local/share"
  ln -s "${DOTFILES}/wallpapers" "${HOME}/.local/share/wallpapers"
fi

if [ ! -f "${HOME}/.local/bin" ] && [ -f "${DOTFILES}/.local/bin" ]; then
  mkdir -p "${HOME}/.local"
  ln -s "${DOTFILES}/.local/bin" "${HOME}/.local/bin"
fi
