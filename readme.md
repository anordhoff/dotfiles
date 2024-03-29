# dotfiles

My `.dotfiles/` repository

```
git clone --recursive https://github.com/anordhoff/dotfiles.git ~/dotfiles
( cd ~/dotfiles/nvim/package/start/telescope-fzf-native && make )
```

```
npm install -g bash-language-server mdless vim-language-server vscode-json-languageserver yarn
```

```
nvim --headless +TSInstall +q
```

### fedora

```
sudo dnf install fzf
```

### macos

```
brew install coreutils fzf
```

### kmonad

```
stack --system-ghc --compiler ghc-8.10.7 install --flag kmonad:dext --extra-include-dirs=c_src/mac/Karabiner-DriverKit-VirtualHIDDevice/include/pqrs/karabiner/driverkit:c_src/mac/Karabiner-DriverKit-VirtualHIDDevice/src/Client/vendor/include
```
