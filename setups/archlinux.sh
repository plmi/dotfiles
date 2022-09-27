#!/bin/bash

function install_common {
  sudo pacman -Syu --noconfirm && sudo pacman -S --noconfirm git pacman-contrib \
    xorg-xinit xorg-server wget zip unzip tmux neofetch p7zip zathura \
    obsidian redshift xwallpaper openvpn xclip sxiv pass unzip
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
    make && sudo make clean install && echo -e "#!/bin/bash\n\nexec dwm" > $HOME/.xinitrc && \
    chmod +x "$HOME/.xinitrc"
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
echo -e "\033[0;32m[+] setup successfully finished\033[0m"
