#!/bin/bash

local_ip() {
  #public="$(dig +short myip.opendns.com @resolver1.opendns.com)"
  #private="$(hostname -I | awk '{print $1}')"
  interface="$1"
  private="$(ip -o -4 addr list ${interface} | awk '{print $4}' | cut -d/ -f1)"
  echo -e "  $private"
}

check_updates_apt() {
  available_updates_count="$(apt-get -q -y --ignore-hold --allow-change-held-packages --allow-unauthenticated -s dist-upgrade \
    | grep  ^Inst | grep -i security | wc -l)"
  echo -e " $available_updates_count"
}

check_updates_pacman() {
  # https://wiki.archlinux.org/title/System_maintenance
  available_updates_count="$(checkupdates | wc -l)"
  echo -e " $available_updates_count"
}

dateTime() {
  dateTime="$(date +"%a. %d.%m %H:%M")"
  echo -e " $dateTime"
}

disk() {
  #device="/dev/sda2"
  device="$1"
  usage=$(df -h 2> /dev/null | grep "$device" | awk '{print $3 "/" $2}')
  echo -e " $usage"
}

up() {
  test=$(uptime | awk '{print $3}' | sed s/,//g)
  echo -e " $test"
}

essid() {
  ssid=$(iwgetid | grep -o '".*"' | sed 's/"//g')
  echo -e "$ssid"
}

battery() {
  remaining=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 \
    | grep "to empty" | awk -F "," '{ print $1 }' | grep -oE "[0-9]+")
  if [ -z "$remaining" ]; then
    echo -e ""
  else
    echo -e " $remaining" min
  fi
}

xsetroot -name "$(disk '/dev/sda2') | $(local_ip 'wlp4s0') | $(up) | $(check_updates_pacman) | $(dateTime)"
