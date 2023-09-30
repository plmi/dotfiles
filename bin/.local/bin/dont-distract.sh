#!/bin/bash

#BLOCKLIST=("foo.com" "bar.com")
LOOPBACK='127.0.0.1'
HOST_FILE='/etc/hosts'
BLOCK_FILE='block.conf'

function log {
  echo "[+] $1"
}

# prompt sudo permissions
if [ $EUID != 0 ]; then
    sudo "$0" "$@"
    exit $?
fi

mapfile -t BLOCKLIST < "$BLOCK_FILE"

for i in "${BLOCKLIST[@]}"; do
  if grep "$i" "$HOST_FILE"; then
    if grep -P "^#$LOOPBACK\t$i" "$HOST_FILE"; then
      # uncomment
      sed -i "/^#$LOOPBACK\t$i/s/^#//g" "$HOST_FILE"
    else
      # comment
      sed -i "/^$LOOPBACK\t$i/ s/./#&/" "$HOST_FILE"
    fi
  else
    # suppress echo output
    { echo -e "$LOOPBACK\t$i"; } | tee -a /etc/hosts >/dev/null
  fi
done

service network-manager restart
