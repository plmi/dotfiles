#!/bin/bash

sudo apt update
sudo apt upgrade -y
sudo apt install build-essential git pass apt-file tmux vim zathura \
  thunderbird zathura redshift dunst neofetch main p7zip-full
# dwm
sudo apt install libx11-dev libxft-dev libxinerama-dev
# anki
sudo apt install libxcb-xinerama0
# virt-manager
sudo apt install qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virt-manager
