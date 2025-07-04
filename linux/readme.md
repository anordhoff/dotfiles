# linux

## gnome

At some point, look into [pop-os/shell](https://github.com/pop-os/shell) as a way to implement a tiling window manager in gnome. pop-os/shell [end-of-life is April 2027](https://github.com/pop-os/shell/discussions/1728)


### menu bar

Install the `gnome-shell-extension-user-theme` package, enable the `user-theme` extension, and select the `mytheme` theme.

Useful references:
- [Reddit thread that helped me get started](https://www.reddit.com/r/gnome/comments/1201ghg/top_bar_customization/)
- [Gist that lists all available options](https://gist.github.com/lidgnulinux/afa745d81004a051aee4ca93f12ecb6c)
- [Another custom gnome-shell.css](https://github.com/cmanallen/gnome-shell/blob/master/themes/refined-shell/gnome-shell.css)


### gestures

Change `GESTURE_FINGER_COUNT` from 3 to 5 in `/usr/lib64/gnome-shell/libshell-16.so` per [this issue](https://www.reddit.com/r/gnome/comments/qrhu0e/guide_to_customize_gnome_40_touchpad_gestures_on)

### keybindings

Running `~/dotfiles/linux/gnome/gsettings.sh` will set most keybindings. To switch focus between windows and monitors, install the [focus-changer extension](https://github.com/martinhjartmyr/gnome-shell-extension-focus-changer)

```
git clone https://github.com/martinhjartmyr/gnome-shell-extension-focus-changer.git $HOME/.local/share/gnome-shell/extensions/focus-changer@heartmire
gnome-extensions enable focus-changer@heartmire
```


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

The [gnome-randr](https://github.com/maxwellainatchi/gnome-randr-rust) command can be used as a replacement for xrandr on Gnome with Wayland. The following commands will configure an external 4k TV alongside the laptop's built-in display:

```
gnome-randr modify eDP-1 --persistent --mode 1920x1080@59.999324798583984 --primary
gnome-randr modify DP-3 --persistent --mode 3840x2160@60
```

Use `gnome-randr query` to verify the configuration or to get the connector ids for each display


## Steam

Use the following launch option to force a game to launch on the secondary monitor (only works for some games):

```
-sdl_displayindex 1
```


## fonts

San Francisco fonts used by Sway can be cloned and installed from the following URLs:
- https://github.com/AppleDesignResources/SanFranciscoFont
- https://www.cufonfonts.com/font/sf-mono


## casting

To prevent Wayland from dropping unfocused windows to 1 fps, launch google chrome with the following args:

```
--args --disable-gpu-vsync --disable-frame-rate-limit
```


## nvidia

Install [proprietary Nvidia open source drivers](https://rpmfusion.org/Howto/NVIDIA) and follow [optimus setup instructions](https://rpmfusion.org/Howto/Optimus). Check that processes are using the Nvidia card with `nvidia-smi`.

NOTE: As of 6/4/25, both `akmod-nivida` and `akmod-nvidia-open` were required. This might be a bug, as only `akmod-nvidia-open` should be needed


### nvidia with swaywm

Swaywm [does not support proprietary graphics drivers](https://github.com/swaywm/sway/wiki#nvidia-users) (this may be out-dated info). Force sway to use the [Intel graphics card](https://github.com/swaywm/sway/wiki#i-have-a-multi-gpu-setup-like-intelnvidia-or-intelamd-and-sway-does-not-start) by updating the session file at `/usr/share/wayland-sessions/sway.desktop` (ensure card0 is the Intel card using `drm_info -j | jq 'with_entries(.value |= .driver.desc)'`)

```
[Desktop Entry]
Name=Sway
Exec=env WLR_DRM_DEVICES=/dev/dri/card0 sway --unsupported-gpu
Type=Application
```
