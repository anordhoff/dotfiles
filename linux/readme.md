# linux

## gnome workspace gestures

Change `GESTURE_FINGER_COUNT` from 3 to 4 in `/usr/lib64/gnome-shell/libshell-12.so`

https://www.reddit.com/r/gnome/comments/qrhu0e/guide_to_customize_gnome_40_touchpad_gestures_on

## suspend

By default, the very inefficient s2idle suspend variant is incorrectly selected.
```
$ cat /sys/power/mem_sleep
[s2idle] deep
```

The much more efficient deep variant should be selected instead by adding the following entry to `/etc/default/grub` and running `grub2-mkconfig -o /boot/grub2/grub.cfg`
```
GRUB_CMDLINE_LINUX_DEFAULT="mem_sleep_default=deep"
```

## display

the [gnome-randr](https://github.com/maxwellainatchi/gnome-randr-rust) command can be used as a replacement for xrandr on gnome with wayland. The following commands will configure an external 4k tv alongside the laptop's built-in display:
```
gnome-randr modify eDP-1 --persistent --mode 1920x1080@59.999324798583984 --primary
gnome-randr modify DP-3 --persistent --mode 3840x2160@60
```

Use `gnome-randr query` to verify the configuration or to get the connector ids for each display

## nvidia

Install [proprietary Nvidia drivers](https://rpmfusion.org/Howto/NVIDIA) and follow [optimus setup instructions](https://rpmfusion.org/Howto/Optimus). Check that processes are using the Nvidia card with `nvidia-smi`

Swaywm [does not support proprietary graphics drivers](https://github.com/swaywm/sway/wiki#nvidia-users). Force sway to use the [Intel graphics card](https://github.com/swaywm/sway/wiki#i-have-a-multi-gpu-setup-like-intelnvidia-or-intelamd-and-sway-does-not-start) by updating the session file at `/usr/share/wayland-sessions/sway.desktop` (ensure card0 is the Intel card using `drm_info -j | jq 'with_entries(.value |= .driver.desc)'`)
```
[Desktop Entry]
Name=Sway
Exec=env WLR_DRM_DEVICES=/dev/dri/card0 sway --unsupported-gpu
Type=Application
```

## fonts

San Francisco fonts used by Sway can be cloned and installed from https://github.com/AppleDesignResources/SanFranciscoFont and https://www.cufonfonts.com/font/sf-mono

## casting

To prevent wayland from dropping unfocused windows to 1 fps, launch google chrome with the following args:
```
--args --disable-gpu-vsync --disable-frame-rate-limit
```
