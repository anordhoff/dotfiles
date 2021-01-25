# ln -s $HOME/.dotfiles/zsh/function.zsh $XDG_DATA_DIR/oh-my-zsh/custom/.

# java lazy loading
jenv() {
    unset -f jenv
    eval "$(jenv init -)"
    jenv "$@"
}

java() {
    unset -f java
    eval "$(jenv init -)"
    java "$@"
}

mvn() {
    unset -f mvn
    eval "$(jenv init -)"
    mvn "$@"
}

# kubectl lazy loading
function kubectl() {
    if ! type __start_kubectl >/dev/null 2>&1; then
        source <(command kubectl completion zsh)
    fi
    command kubectl "$@"
}

if [[ "$OSTYPE" == "linux-gnu"* ]]; then

    # connect/disconnect from vpn
    vpn() {
        default='dev'
        if [[ $2 == '' ]]; then
            2=$default
        fi
        if [[ $1 == 'connect' ]]; then
            nmcli connection up $2
            sudo systemctl restart systemd-resolved
        elif [[ $1 == 'disconnect' ]]; then
            nmcli connection down $2
        else
          nmcli connection "$@"
        fi
    }
fi
