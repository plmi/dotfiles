#!/bin/bash

function install_docker {
  zypper install docker docker-compose docker-compose-switch &&
    sudo usermod -aG docker $USER
}

function install_packages {
  sudo zypper install waybar swww swww-zsh-completion gammastep kitty chromium mpv mpd mpc ncmpcpp neovim zoxide zsh yazi yazi-zsh-completion wl-clipboard wl-clipboard-zsh-completion fzf aria2 dconf-editor zathura wlr-randr virt-manager rofi-wayland rclone qbittorrent password-store hyprland fastfetch grim slurp
}

function install_cliphist {
  wget "https://github.com/sentriz/cliphist/releases/download/v0.5.0/v0.5.0-linux-amd64" --directory-prefix /tmp/ &&
    chmod +x v0.5.0-linux-amd64 &&
    sudo mv /tmp/v0.5.0-linux-amd64 /usr/local/bin/
}

function install_rofi_menus {
  asdf
}

sudo zypper refresh &&
  sudo zypper update &&
  install_packages &&
  install_docker &&
  install_cliphist &&
  echo "Installation finished!"
