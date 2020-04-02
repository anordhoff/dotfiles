#!/bin/sh

icon=" "

if [[ 'nmcli device | grep -q tun' ]]; then
  info=$(nmcli connection show | awk '/vpn/ {print $1}')
  if [[ ${#info} > 40 ]]; then
    info=$(echo $info | cut -c1-40)"..."
  fi
  text=$info"  "$icon
  class="connected"
else
  text=""
  class="disconnected"
fi

echo -e "{\"text\":\"$text\", \"class\":\"$class\"}"
