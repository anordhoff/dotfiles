#!/bin/sh

if nmcli device | grep -q tun; then
  info=$(protonvpn-cli status | awk '/Server:/ {print $2}')
  if [[ $info == "" ]]; then
    info='connected'
  fi
  text="Vpn: $info"
  class='connected'
else
  text='Vpn: disconnected'
  class='disconnected'
fi

echo -e "{\"text\":\"$text\", \"class\":\"$class\"}"
