# dotfiles

`~/.dotfiles/` directory for Ubuntu 19.04

## vim

See installation steps at https://github.com/junegunn/vim-plug

```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim ~/.dotfiles/vim/.vimrc
:PlugInstall
:GoInstallBinaries
```

## tmux

Add to beginning of `~/.bashrc`

```
# start tmux on shell login
[[ -z "$TMUX" ]] && exec tmux
```

