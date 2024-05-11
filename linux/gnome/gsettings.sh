#!/bin/sh

# --------------------------------------
# settings
# --------------------------------------

# night shift
gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
gsettings set org.gnome.settings-daemon.plugins.color night-light-temperature 3000

# clock
gsettings set org.gnome.desktop.interface clock-format 12h
gsettings set org.gtk.Settings.FileChooser clock-format 12h

# disable animations
gsettings set org.gnome.desktop.interface enable-animations false

# disable hot corners
gsettings set org.gnome.desktop.interface enable-hot-corners false

# always have 10 workspaces
gsettings set org.gnome.mutter dynamic-workspaces false
gsettings set org.gnome.desktop.wm.preferences num-workspaces 10

# disable system sounds
gsettings set org.gnome.desktop.sound event-sounds false

# turn off the screen after 15 minutes
gsettings set org.gnome.desktop.session idle-delay 900
gsettings set org.gnome.desktop.interface show-battery-percentage true

# lock the computer 5 minutes after screen turns off
gsettings set org.gnome.desktop.screensaver lock-delay 300

# touchpad speed
gsettings set org.gnome.desktop.peripherals.touchpad speed 0.2
gsettings set org.gnome.desktop.peripherals.mouse double-click 300

# keyboard settings
gsettings set org.gnome.desktop.peripherals.keyboard delay 250
gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 30


# --------------------------------------
# keybindings
# --------------------------------------

# unset conflicting key bindings
gsettings set org.gnome.shell.keybindings show-screen-recording-ui '[]'

# disable default launcher key
gsettings set org.gnome.mutter overlay-key ''

# disable alternate characters key by setting to menu key
gsettings set org.gnome.desktop.input-sources xkb-options '["lv3:menu_switch"]'

# disable <super>m shortcut
gsettings set org.gnome.shell.keybindings toggle-message-tray '["<Super>v"]'

# toggle dark mode
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'toggle-theme'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'gnome-terminal -- /bin/sh -c "$HOME/dotfiles/linux/gnome/toggle-theme.sh"'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Shift><Control><Alt><Super>m'

# open the application launcher
gsettings set org.gnome.settings-daemon.plugins.media-keys search '["<Shift><Control><Alt>escape"]'

# resize window
gsettings set org.gnome.mutter.keybindings toggle-tiled-left '["<Shift><Control><Alt><Super>n"]'
gsettings set org.gnome.mutter.keybindings toggle-tiled-right '["<Shift><Control><Alt><Super>o"]'
gsettings set org.gnome.desktop.wm.keybindings toggle-maximized '["<Shift><Control><Alt>z"]'

# close window
gsettings set org.gnome.desktop.wm.keybindings close '["<Shift><Control><Alt>q"]'

# lock screen
gsettings set org.gnome.settings-daemon.plugins.media-keys screensaver '["<Shift><Control><Alt>question"]'

# switch window
gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward '["<Shift><Control><Alt>n"]'
gsettings set org.gnome.desktop.wm.keybindings switch-windows '["<Shift><Control><Alt>o"]'

# switch workspace
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left '["<Shift><Control><Alt>u"]'
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right '["<Shift><Control><Alt>y"]'

# move window to workspace
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left '["<Shift><Control><Alt><Super>u"]'
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right '["<Shift><Control><Alt><Super>y"]'

# switch workspace
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 '["<Shift><Control><Alt>x"]'
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 '["<Shift><Control><Alt>c"]'
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 '["<Shift><Control><Alt>d"]'
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 '["<Shift><Control><Alt>r"]'
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-5 '["<Shift><Control><Alt>s"]'
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-6 '["<Shift><Control><Alt>t"]'
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-7 '["<Shift><Control><Alt>w"]'
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-8 '["<Shift><Control><Alt>f"]'
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-9 '["<Shift><Control><Alt>p"]'
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-10 '["<Shift><Control><Alt>a"]'

# move window to workspace
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-1 '["<Shift><Control><Alt><Super>x"]'
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-2 '["<Shift><Control><Alt><Super>c"]'
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-3 '["<Shift><Control><Alt><Super>d"]'
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-4 '["<Shift><Control><Alt><Super>r"]'
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-5 '["<Shift><Control><Alt><Super>s"]'
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-6 '["<Shift><Control><Alt><Super>t"]'
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-7 '["<Shift><Control><Alt><Super>w"]'
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-8 '["<Shift><Control><Alt><Super>f"]'
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-9 '["<Shift><Control><Alt><Super>p"]'
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-10 '["<Shift><Control><Alt><Super>a"]'

# switch window to monitor
gsettings set org.gnome.desktop.wm.keybindings move-to-monitor-left '["<Shift><Control><Alt><Super>minus"]'
gsettings set org.gnome.desktop.wm.keybindings move-to-monitor-right '["<Shift><Control><Alt><Super>equal"]'
