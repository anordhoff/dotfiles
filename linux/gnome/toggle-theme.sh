#!/bin/bash

if [[ $(gsettings get org.gnome.desktop.interface color-scheme) == "'prefer-light'" ]]; then
  gsettings set org.gnome.desktop.interface color-scheme prefer-dark
else
  gsettings set org.gnome.desktop.interface color-scheme prefer-light
fi
