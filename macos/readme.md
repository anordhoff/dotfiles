# macos

## tools:

- [AeroSpace](https://github.com/nikitabobko/AeroSpace)
- [MultiTouch](https://multitouch.app/)
- [HazeOver](https://hazeover.com/)
- [Ice](https://github.com/jordanbaird/Ice)
- [Maccy](https://maccy.app/)
- [AppearanceNotifier](https://github.com/jesse-c/AppearanceNotifier)
- [SpotMenu v1.8](https://github.com/kmikiy/SpotMenu)


## less distracting wallpaper

- [Wallpapper](https://github.com/mczachurski/wallpapper)
- [ChangeMenuBarColor](https://github.com/igorkulman/ChangeMenuBarColor)

```wallpapper.json
[
  {
    "fileName": "sepia.png",
    "isPrimary": true,
    "isForLight": true
  },
  {
    "fileName": "gray.png",
    "isForDark": true
  }
]
```


## tmux-256color

MacOS has ncurses version 5.7 which does not ship the terminfo description for tmux. Compile the latest ncurses terminal descriptions for tmux-256color: https://gist.github.com/bbqtd/a4ac060d6f6b9ea6fe3aabe735aa9d95


## gpg

Set up GPG to use pinentry [when signing commits](https://gist.github.com/troyfontaine/18c9146295168ee9ca2b30c00bd1b41e).


## kmonad

Install the following dependencies before compiling kmonad:
NOTE: `llvm@12,` `ghc@8.10,` and `ghc@9.4` might not be needed anymore

```
brew install llvm@12 llvm ghc@8.10 ghc@9.4 ghc haskell-stack # 
```

Then, [install dext](https://github.com/kmonad/kmonad/blob/master/doc/installation.md#installing-the-dext).

Finally, install kmonad using the basic installation command. If the basic installation command does not work, try the following:

```
stack --system-ghc --compiler ghc-8.10.7 install --flag kmonad:dext --extra-include-dirs=c_src/mac/Karabiner-DriverKit-VirtualHIDDevice/include/pqrs/karabiner/driverkit:c_src/mac/Karabiner-DriverKit-VirtualHIDDevice/src/Client/vendor/include
```

After installation, give kmonad `Input Monitoring` permissions, create symlinks, and start kmonad:

```
sudo ln -s ~/.local/bin/kmonad /usr/local/bin/kmonad
sudo ln -s ~/dotfiles/kmonad/mac.kbd /usr/local/share/kmonad/mac.kbd
sudo ln -s ~/dotfiles/kmonad/local.kmonad.plist /Library/LaunchDaemons/local.kmonad.plist
sudo launchctl load -w /Library/LaunchDaemons/local.kmonad.plist
```

see [kmonad issue #334](https://github.com/kmonad/kmonad/issues/334#issuecomment-1000106276) for more info


## multitouch

Disable the default `Minimize` keyboard shortcut (cmd-m) in settings.

| Trackpad Gesture | Action |
| --- | --- |
| 3 finger click | middle click |
| 3 finger tap | middle click |
| 3 finger swipe up | browser tabs left |
| 3 finger swipe down | browser tabs right |
| 3 finger swipe left | kitty `option-a_p` |
| 3 finger swipe right | kitty `option-a_n` |
| 4 finger swipe up | browser reopen closed tab |
| 4 finger swipe down | browser close tab |
| 4 finger swipe left | `/opt/homebrew/bin/aerospace focus-monitor prev` |
| 4 finger swipe right | `/opt/homebrew/bin/aerospace focus-monitor next` |
| 3 force touch | browser reload page |

| Keyboard Shortcut | Action |
| --- | --- |
| hyper-m | `osascript ~/dotfiles/macos/multitouch/toggle-appearance.scpt` |

Four finger swiping up and down was also scrolling the page. I fixed this by:
1. setting `Mission Control` and `App Expose` to four finger swipe in settings
2. setting both options to three finger swipe
3. setting both options to off

Similarly, I prevented four finger swiping left and right from dragging the screen by setting `Swipe between full-screen applications` to four finger swipe.


## skhd

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
