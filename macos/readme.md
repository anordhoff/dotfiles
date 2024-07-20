# macos

### tmux-256color

macOS has ncurses version 5.7 which does not ship the terminfo description for tmux. Compile the latest ncurses terminal descriptions for tmux-256color: https://gist.github.com/bbqtd/a4ac060d6f6b9ea6fe3aabe735aa9d95

### gpg

set up GPG to use pinentry: https://gist.github.com/troyfontaine/18c9146295168ee9ca2b30c00bd1b41e

### kmonad

```
brew install llvm@12 llvm ghc@8.10 ghc@9.4 ghc haskell-stack # llvm@12, ghc@8.10, ghc@9.4 might not be needed anymore
```

[install dext](https://github.com/kmonad/kmonad/blob/master/doc/installation.md#installing-the-dext), and then install kmonad using (can now use basic installation command):
```
stack --system-ghc --compiler ghc-8.10.7 install --flag kmonad:dext --extra-include-dirs=c_src/mac/Karabiner-DriverKit-VirtualHIDDevice/include/pqrs/karabiner/driverkit:c_src/mac/Karabiner-DriverKit-VirtualHIDDevice/src/Client/vendor/include
```

give kmonad `Input Monitoring` permissions, create symlinks, and start kmonad:
```
sudo ln -s ~/.local/bin/kmonad /usr/local/bin/kmonad
sudo ln -s ~/dotfiles/kmonad/mac.kbd /usr/local/share/kmonad/mac.kbd
sudo ln -s ~/dotfiles/kmonad/local.kmonad.plist /Library/LaunchDaemons/local.kmonad.plist
sudo launchctl load -w /Library/LaunchDaemons/local.kmonad.plist
```

see [kmonad issue #334](https://github.com/kmonad/kmonad/issues/334#issuecomment-1000106276) for more info

### tools:

- [Bartender](https://www.macbartender.com)
- [Linear Mouse](https://linearmouse.org/)
- [SpotMenu v1.8](https://github.com/kmikiy/SpotMenu)
- [Space ID](https://github.com/dshnkao/SpaceId)
- [BetterTouchTool](https://folivora.ai/)
- [HazeOver](https://hazeover.com/)

### less distracting wallpaper

- [ChangeMenuBarColor](https://github.com/igorkulman/ChangeMenuBarColor)
- [Wallpapper](https://github.com/mczachurski/wallpapper)

### shortcuts

| category | shortcut | keybinding |
| -- | -- | -- |
| Mission Control | Move left a space | meh-[ |
| Mission Control | Move right a space | meh-] |
| Mission Control | Switch to Desktop 1 | meh-x |
| Mission Control | Switch to Desktop 2 | meh-c |
| Mission Control | ... | ... |
| Mission Control | Switch to Desktop 9 | meh-p |
| Mission Control | Switch to Desktop 10 | meh-a |
| Screenshots | Save a picture of screen as a file | opt-cmd-F13 |
| Screenshots | Copy picture of screen to the clipboard | opt-F13 |
| Screenshots | Save picture of selected area as a file | cmd-F13 |
| Screenshots | Copy picture of selected area to the clipboard | F13 |
| Screenshots | Screenshot and recording options | ctrl-F13 |
| Spotlight | Show Spotlight search | meh-minus |
| App Shortcuts | All Applications > Lock Screen | meh-/ |
