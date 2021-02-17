## macos

#### keyboard

Keyboard layout was generated using SIL Language Technology's Ukelele

Swap Control and Command keys: `System Preferences > Keyboard > Modifier Keys > Apple Internal Keyboard`

```
$ tar -C $HOME/.dotfiles/macos/keyboard -xzf $HOME/.dotfiles/macos/keyboard/custom.bundle.tar.gz
$ ln -s $HOME/.dotfiles/macos/keyboard/custom.bundle $HOME/Library/Keyboard\ Layouts/.
$ chmod +x $HOME/.dotfiles/macos/keyboard/options.sh
$ sudo defaults write com.apple.loginwindow LoginHook $HOME/.dotfiles/macos/keyboard/options.sh
```

## Karabiner Elements

Symbolic link: [https://karabiner-elements.pqrs.org/docs/manual/misc/configuration-file-path/#about-symbolic-link](https://karabiner-elements.pqrs.org/docs/manual/misc/configuration-file-path/#about-symbolic-link)

Reboot for the changes to take effect

#### tools

[WhichSpace](https://github.com/gechr/WhichSpace)

[Bearded Spice](https://github.com/beardedspice/beardedspice)

[Scroll Reverser](https://github.com/pilotmoon/Scroll-Reverser)

[autokbisw](https://github.com/jeantil/autokbisw)

[SpotMenu](https://github.com/kmikiy/SpotMenu) (install v1.8 to disable scrolling text)

#### yabai/skhd

Change mission control shortcuts: `System Preferences > Keyboard > Shortcuts > Mission Control`

```
Mission Control:      Ctrl-Up
Show Desktop:         Ctrl-Down
Move left a space:    Command-a
Move right a space:   Command-t
Switch to Desktop 1:  Command-1
Switch to Desktop 2:  Command-2
...
Switch to Desktop 10: Command-0
```

Add a shortcut under `App Shortcuts`:
```
Lock Screen: Ctrl-Command-l
```
