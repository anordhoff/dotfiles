# dotfiles

`~/.dotfiles/` directory for Arch Linux

### bluetooth

with headphones disconnected:

```
amixer -c 0 set Speaker 100%
amixer -c 0 set Speaker unmute
amixer -c 0 set Headphone 0%
amixer -c 0 set Headphone mute
```

with headphones connected:

```
amixer -c 0 set Speaker 0%
amixer -c 0 set Speaker mute
amixer -c 0 set Headphone 100%
amixer -c 0 set Headphone unmute
```

bluetooth:

https://wiki.archlinux.org/index.php/Bluetooth_headset#Configuration_via_CLI

https://wiki.archlinux.org/index.php/Bluetooth_headset#Apple_Airpods_have_low_volume

if no volume, try disconnecting, executing `sudo pkill pulseaudio`, and reconnect

```
pacmd list-sinks
pactl set-sink-volume name_of_bluetooth_speaker x%
```

### input

gnome:

install dconf-editor
mouse acceleration: org/gnome/desktop/peripherals/mouse/acceleration-profile
keyboard repeat rate/delay: org/gnome/desktop/peripherals/keyboard
remap caps to ctrl: org/gnome/desktop/input-sources/xkb-options, add `[ctrl:nocaps']`

### font

icons: `ttf-font-awesome`

### firefox

shadowfox: https://github.com/overdodactyl/ShadowFox
