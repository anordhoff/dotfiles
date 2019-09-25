for DOTFILE in `find ~/.dotfiles/shell/profile`
do
    [ -f "$DOTFILE" ] && source "$DOTFILE"
done
