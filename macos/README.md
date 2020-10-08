## macos

#### keyboard

Keyboard layout was generated using SIL Language Technology's Ukelele

```
tar -C $HOME/.dotfiles/macos/keyboard -xzf $HOME/.dotfiles/macos/keyboard/custom.bundle.tar.gz
ln -s $HOME/.dotfiles/macos/keyboard/custom.bundle $HOME/Library/Keyboard\ Layouts/.
chmod +x $HOME/.dotfiles/macos/keyboard/options.sh
chmod +x $HOME/.dotfiles/macos/keyboard/reset.sh
```

To change modifier key mappings at startup:

```
sudo defaults write com.apple.loginwindow LoginHook $HOME/.dotfiles/macos/keyboard/options.sh
```

Reboot for the changes to take effect

#### tools

[WhichSpace](https://github.com/gechr/WhichSpace)

[Bearded Spice](https://github.com/beardedspice/beardedspice)

[Scroll Reverser](https://github.com/pilotmoon/Scroll-Reverser)

[autokbisw](https://github.com/jeantil/autokbisw)

[SpotMenu](https://github.com/kmikiy/SpotMenu) (install v1.8 to disable scrolling text)

#### yabai/skhd

Change mission control shortcuts: `System Preferences > Keyboard > Shortcuts > Mission Control`
