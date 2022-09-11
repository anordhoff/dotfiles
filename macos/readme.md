## keyboard

Keyboard layout was generated using SIL Language Technology's Ukelele

Swap Control and Command keys: `System Preferences > Keyboard > Modifier Keys > Apple Internal Keyboard`

```
$ tar -C ~/.dotfiles/macos/keyboard -xzf ~/.dotfiles/macos/keyboard/custom.bundle.tar.gz
$ ln -s ~/.dotfiles/macos/keyboard/custom.bundle ~/Library/Keyboard\ Layouts/.
$ chmod +x ~/.dotfiles/macos/keyboard/options.sh
$ sudo defaults write com.apple.loginwindow LoginHook ~/.dotfiles/macos/keyboard/options.sh
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

[f.lux](https://justgetflux.com)

[BetterTouchTool](https://folivora.ai/)

#### yabai/skhd

Change mission control shortcuts: `System Preferences > Keyboard > Shortcuts > Mission Control`

```
Switch to Desktop 1:  Command-1
Switch to Desktop 2:  Command-2
...
Switch to Desktop 10: Command-0
```

Add a shortcut under `App Shortcuts`:
```
Lock Screen: Command-l
```

https://github.com/universal-ctags/ctags

https://gist.github.com/bbqtd/a4ac060d6f6b9ea6fe3aabe735aa9d95
