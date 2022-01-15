#!/bin/bash

output=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I)
airport=$(echo "$output" | grep 'AirPort' | awk -F': ' '{print $2}')

if [ "$airport" = "Off" ]; then
  echo " offline"
else
  echo "$(echo "$output" | grep ' SSID' | awk '{print $2}')"
fi
