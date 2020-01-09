# dotfiles

`~/.dotfiles/` directory for Ubuntu 19.10

To begin, clone the repository to `~/.dotfiles/`, and install necessary packages

```
git clone https://github.com/anordhoff/dotfiles.git ~/.dotfiles/
sudo apt-get update
sudo apt-get install i3
sudo apt-get install i3-wm dunst i3lock i3status suckless-tools
sudo apt-get install compton rxvt-unicode xsel rofi fonts-noto xsettingsd lxappearance scrot feh amixer playerctl xclip
```

Also install the binary for light: [https://github.com/haikarainen/light]

Finally, create symlinks for each tool used

### bash

Source `.bashrc` at end of `~/.bashrc`

```
echo "source ~/.dotfiles/bash/.bashrc" >> ~/.bashrc
```

### compton

```
ln -s $HOME/.dotfiles/compton/compton.conf $HOME/.config/compton.conf
```

### dunst

```
ln -s $HOME/.dotfiles/dunst/dunstrc $HOME/.config/dunst/dunstrc
```

### git

```
ln -s $HOME/.dotfiles/git/.gitconfig $HOME/.gitconfig
ln -s $HOME/.dotfiles/git/.gitignore $HOME/.gitignore
```

### i3

```
ln -s $HOME/.dotfiles/i3/config $HOME/.config/i3/config
ln -s $HOME/.dotfiles/i3/i3status.conf $HOME/.config/i3status/config
ln -s $HOME/.dotfiles/i3/fonts/icomoon/ $HOME/.fonts/icomoon
fc-cache -fv
```

### tmux

Add to beginning of default shell config file

```
# start tmux on shell login
[[ -z "$TMUX" ]] && exec tmux
```

Then, create a symlink

```
ln -s $HOME/.dotfiles/tmux/.tmux.conf $HOME/.tmux.conf
```

### vim

```
ln -s $HOME/.dotfiles/vim/.vimrc $HOME/.vimrc
```

See installation steps at https://github.com/junegunn/vim-plug

```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim ~/.dotfiles/vim/.vimrc
:PlugInstall
:GoInstallBinaries
```

### xorg

```
ln -s $HOME/.dotfiles/xorg/.Xresources $HOME/.Xresources
ln -s $HOME/.dotfiles/xorg/.xsettingsd $HOME/.xsettingsd
```

