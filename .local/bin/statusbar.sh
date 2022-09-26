#!/bin/bash

export WEATHER_DEG=0

ip() {
  public="$(dig +short myip.opendns.com @resolver1.opendns.com)"
  private="$(hostname -I | awk '{print $1}')"
  echo -e "  $private"
}

updates() {
  updates="$(apt-get -q -y --ignore-hold --allow-change-held-packages --allow-unauthenticated -s dist-upgrade \
    | grep  ^Inst | grep -i security | wc -l)"
  echo -e " $updates"
}

dateTime() {
  dateTime="$(date +"%a. %d.%m %H:%M")"
  echo -e " $dateTime"
}

disk() {
  device="/dev/sda3"
  usage=$(df -h 2> /dev/null | grep "$device" | awk '{print $3 "/" $2}')
  echo -e " $usage"
}

weather() {
  POSTAL_CODE='10115'
  WEATHER_DEG="$(curl -fGsS --compressed "wttr.in/${POSTAL_CODE}?0q" | grep -Eo "[+,-][0-9]{1,2}" | awk '{print substr($1,2);}')"
  echo -e " $WEATHER_DEG°C"
}

bitcoin() {
  btc=$(curl -sS --compressed https://api.coinbase.com/v2/prices/spot?currency=USD | jq '.data.amount' | sed s/\"//g | cut -d. -f1)
  echo -e " $btc"
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

xsetroot -name "$(disk) | $(ip) | $(updates) | $(up) | $(battery) | $(dateTime)"
