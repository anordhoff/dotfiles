# dotfiles

`~/.dotfiles/` directory for Arch Linux

### audio

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

arch:

remap caps lock to escape and control: https://aur.archlinux.org/packages/interception-caps2esc

add this job to `/etc/udevmon.yaml`:
```
- JOB: "intercept -g $DEVNODE | caps2esc | uinput -d $DEVNODE"
  DEVICE:
    EVENTS:
      EV_KEY: [KEY_CAPSLOCK, KEY_ESC]
```

swap right alt right ctrl: https://askubuntu.com/a/885047

gnome:

install dconf-editor
mouse acceleration: org/gnome/desktop/peripherals/mouse/acceleration-profile
keyboard repeat rate/delay: org/gnome/desktop/peripherals/keyboard
remap caps to ctrl: org/gnome/desktop/input-sources/xkb-options, add `[ctrl:nocaps']`

### font

icons: `ttf-font-awesome`

### firefox

shadowfox: https://github.com/overdodactyl/ShadowFox

### tools
bat

### vim-go

edit `~/.local/share/nvim/plugged/vim-go/autoload/fzf/decls.vim`

change lines 136 and 148:
```
...
" let normal_bg = s:code("Normal", "bg")
let normal_bg = s:code("CursorLine", "bg")
...
" \ 'options': '-n 1 --ansi --prompt "GoDecls> " --expect=ctrl-t,ctrl-v,ctrl-x'.colors,
\ 'options': '-n 1 --ansi --prompt "GoDecls> " --expect=ctrl-t,ctrl-v,ctrl-s'.colors,
...
```
