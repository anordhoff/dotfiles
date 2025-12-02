# linux

## gnome

At some point, look into [pop-os/shell](https://github.com/pop-os/shell) as a way to implement a tiling window manager in gnome. pop-os/shell [end-of-life is April 2027](https://github.com/pop-os/shell/discussions/1728).


### menu bar

Install the `gnome-shell-extension-user-theme` package, enable the `user-theme` extension, and select the `mytheme` theme.

Useful references:
- [Reddit thread that helped me get started](https://www.reddit.com/r/gnome/comments/1201ghg/top_bar_customization/)
- [Gist that lists all available options](https://gist.github.com/lidgnulinux/afa745d81004a051aee4ca93f12ecb6c)
- [Another custom gnome-shell.css](https://github.com/cmanallen/gnome-shell/blob/master/themes/refined-shell/gnome-shell.css)


### gestures

Change `GESTURE_FINGER_COUNT` from 3 to 5 in `/usr/lib64/gnome-shell/libshell-17.so` per [this issue](https://www.reddit.com/r/gnome/comments/qrhu0e/guide_to_customize_gnome_40_touchpad_gestures_on).


### keybindings

Running `~/dotfiles/linux/gnome/gsettings.sh` will configure most keybindings. To switch focus between windows and monitors, install the [focus-changer extension](https://github.com/martinhjartmyr/gnome-shell-extension-focus-changer).

```
git clone https://github.com/martinhjartmyr/gnome-shell-extension-focus-changer.git $HOME/.local/share/gnome-shell/extensions/focus-changer@heartmire
gnome-extensions enable focus-changer@heartmire
```


### display

The [gnome-randr-rust](https://github.com/maxwellainatchi/gnome-randr-rust) command can be used as a replacement for xrandr on Gnome with Wayland. The following commands will configure an external 4k TV alongside the laptop's built-in display:

```
gnome-randr modify eDP-1 --persistent --mode 1920x1080@59.999324798583984 --primary
gnome-randr modify DP-3 --persistent --mode 3840x2160@60
```

Use `gnome-randr query` to verify the configuration or to get the connector ids for each display.


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


## steam

Use the following launch option to force a game to launch on the secondary monitor (only works for some games):

```
-sdl_displayindex 1
```


## runelite

This command fixes the RuneLite resolution issue when an external display is scaled to 125%
```
sudo flatpak override --env=GDK_SCALE=2 --env=__NV_PRIME_RENDER_OFFLOAD=1 --env=__GLX_VENDOR_LIBRARY_NAME=nvidia net.runelite.RuneLite
```


## fonts

San Francisco fonts can be cloned and installed from the following URLs:
- https://github.com/AppleDesignResources/SanFranciscoFont
- https://www.cufonfonts.com/font/sf-mono


## casting

To prevent Wayland from dropping unfocused windows to 1 fps, launch google chrome with the following args:

```
--args --disable-gpu-vsync --disable-frame-rate-limit
```


## nvidia

Install [proprietary Nvidia open source drivers](https://rpmfusion.org/Howto/NVIDIA) and follow [optimus setup instructions](https://rpmfusion.org/Howto/Optimus). Check that processes are using the Nvidia card with `nvidia-smi`.

[This page](https://rpmfusion.org/Howto/Optimus) documents how to configure Optimus for better battery life. Adding these [udev rules](https://wiki.archlinux.org/title/PRIME#NVIDIA) should help, too.

NOTE: As of 6/4/25, both `akmod-nivida` and `akmod-nvidia-open` were required. This might be a bug, as only `akmod-nvidia-open` should be needed.
