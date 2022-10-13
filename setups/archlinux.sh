#!/bin/bash

function install_common {
  sudo pacman -Syu --noconfirm && sudo pacman -S --noconfirm git pacman-contrib \
    xorg-xinit xorg-server wget zip unzip tmux neofetch p7zip zathura zathura-pdf-mupdf \
    obsidian redshift xwallpaper openvpn xclip sxiv pass unzip xorg-xsetroot dunst \
    net-tools inetutils maim inotify-tools
}

function setup_dotfiles {
  DOTFILES_DIR="$HOME/dotfiles"
  checkout "https://github.com/plmi/dotfiles.git" "$DOTFILES_DIR" && \
    cd "$DOTFILES_DIR" && chmod +x ./setup.sh && ./setup.sh
}

function install_zsh {
  sudo pacman -S --noconfirm zsh && \
    sudo chsh -s $(which zsh) $USER && cd "$HOME" && curl -L git.io/antigen > antigen.zsh
}

function checkout {
  URL="$1"
  DESTINATION="$2"
  rm -rf "$2" && git clone "$URL" "$DESTINATION"
}

function install_ssh {
  # TODO: setup key
  sudo pacman -S --noconfirm openssh && sudo systemctl enable sshd
}

function install_dwm {
  DWM_FOLDER="$1"
  checkout "https://github.com/plmi/dwm-arch.git" "$DWM_FOLDER" && \
    cd "$DWM_FOLDER" && git apply dwm-scratchpad-6.3.patch && \
    make && \
    sudo make clean install 
#    echo | tee /usr/share/xsessions/dwm.desktop << EndOfMessage
#[Desktop Entry]
#Encoding=UTF-8
#Name=Dwm
#omment=Dynamic window manager
#Exec=/usr/local/bin/dwm
#Icon=dwm
#Type=XSession
#EndOfMessage
}

function install_yay {
  YAY_DIR="$1"
  sudo pacman -S --noconfirm --needed git base-devel && \
    checkout "https://aur.archlinux.org/yay.git" "$YAY_DIR" && \
    cd "$YAY_DIR" && makepkg --noconfirm -si && yay -Y --gendb
}

function install_aur_packages {
  echo y | LANG=C yay --noprovides --answerdiff None --answerclean None --mflags "--noconfirm" -S \
    nerd-fonts-jetbrains-mono google-chrome powershell-bin autojump
}

function install_st {
  ST_DIR="$1"
  checkout "https://github.com/plmi/st-arch.git" "$1" && \
    cd "$ST_DIR" && git apply selpaste.diff && make && sudo make clean install
}

function install_dmenu {
  DMENU_DIR="$1"
  checkout "https://git.suckless.org/dmenu" "$DMENU_DIR" && \
    cd "$DMENU_DIR" && make && sudo make clean install
}

function install_pyenv {
  sudo pacman -S --noconfirm --needed base-devel openssl zlib xz tk && \
    checkout "https://github.com/pyenv/pyenv.git" "$HOME/.pyenv"
}

function install_anki {
  echo y | LANG=C yay --noprovides --answerdiff None --answerclean None --mflags "--noconfirm" -S anki-official-binary-bundle && \
  sudo pacman --noconfirm --needed -S libxcb xcb-util-wm xcb-util-keysyms xcb-util-renderutil
}

function install_vmware_workstation {
  sudo pacman -S --noconfirm linux-headers && \
  echo y | LANG=C yay --noprovides --answerdiff None --answerclean None --mflags "--noconfirm" -S vmware-workstation && \
  sudo systemctl enable vmware-networks.service && \
  sudo modprobe -a vmw_vmci vmmon
}

function install_browserpass {
  sudo pacman -S --noconfirm browserpass qt5-base && \
  echo y | LANG=C yay --noprovides --answerdiff None --answerclean None --mflags "--noconfirm" -S browserpass-chrome && \
  echo 'pinentry-program /usr/bin/pinentry-qt' > "$HOME/.gnupg/gpg-agent.conf"
}

function install_music {
  sudo pacman -S --noconfirm --needed mpc mpd ncmpcpp
}

function install_docker {
  sudo pacman -S --noconfirm --needed docker docker-compose && \
  sudo usermod -aG docker $USER
}

function install_latex {
  sudo pacman -S --noconfirm --needed texlive-most
}

function set_timezone {
  TIMEZONE="Europe/Berlin"
  sudo timedatectl set-timezone "$TIMEZONE"
}

function setup_hp_printer {
  sudo pacman -S --noconfirm --needed cups avahi hplip && \
  sudo systemctl enable cup && \
  sudo systemctl start cups && \
  sudo systemctl enable avahi-daemon && \
  sudo systemctl start avahi-daemon
  # visit https://localhost:631/ > Administration > Add Printer
}

mkdir -p $HOME/.local/src
SOURCE_DIRECTORY="$HOME/.local/src"

install_common && \
install_yay "$HOME/.local/src/yay" && install_aur_packages && \
install_zsh && \
install_dwm "$SOURCE_DIRECTORY/dwm" && \
install_dmenu "$SOURCE_DIRECTORY/dmenu" && \
install_st "$SOURCE_DIRECTORY/st" && \
setup_dotfiles && \
install_ssh && \
install_pyenv && \
install_anki && \
install_vmware_workstation && \
install_browserpass && \
echo -e "\033[0;32m[+] setup successfully finished\033[0m"
