# dotfiles

`~/.dotfiles/` directory for Ubuntu 19.04

## shell

Source `.profile` at end of default shell config file
```
source ~/.dotfiles/shell/.profile
```

## tmux

Add to beginning of default shell config file
```
# start tmux on shell login
[[ -z "$TMUX" ]] && exec tmux
```

## vim

See installation steps at https://github.com/junegunn/vim-plug
```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim ~/.dotfiles/vim/.vimrc
:PlugInstall
:GoInstallBinaries
```

