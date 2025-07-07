# macos

Disable the default "Minimize" keyboard (cmd-m)

### tools:

- [AeroSpace](https://github.com/nikitabobko/Aerospace)
- [Ice](https://github.com/jordanbaird/Ice)
- [HazeOver](https://hazeover.com/)
- [AppearanceNotifier](https://github.com/jesse-c/AppearanceNotifier)
- [MultiTouch](https://multitouch.app/)
- [Maccy](https://maccy.app/)

#### not currently used at work machine

- [SpotMenu v1.8](https://github.com/kmikiy/SpotMenu)

#### less distracting wallpaper

- [ChangeMenuBarColor](https://github.com/igorkulman/ChangeMenuBarColor)
- [Wallpapper](https://github.com/mczachurski/wallpapper)


### skhd

To improve skhd perfomance, run `skhd --install-service` and add the following
to the plist
```
    <key>EnvironmentVariables</key>
    <dict>
        ...
        <key>SHELL</key>
        <string>/bin/dash</string>
    </dict>
```

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

### gestures

| --- | --- |
| 4 Finger Swipe Up | `/opt/homebrew/bin/aerospace workspace prev` |
| 4 Finger Swipe Down | `/opt/homebrew/bin/aerospace workspace next` |
| 4 Finger Swipe Left | `/opt/homebrew/bin/aerospace focus-monitor prev` |
| 4 Finger Swipe Right | `/opt/homebrew/bin/aerospace focus-monitor next` |
| Hyber-M | `osascript ~/dotfiles/macos/gestures/toggle-appearance.scpt` |

Four finger swiping up and down was also scrolling the page. I somehow fixed this by setting Mission Control and App Expose to four finger swipe, then setting them to three finger swipe, and finally setting them to off.
