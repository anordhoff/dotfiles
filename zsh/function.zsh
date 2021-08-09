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
kubectl() {
    if ! type __start_kubectl >/dev/null 2>&1; then
        source <(command kubectl completion zsh)
    fi
    command kubectl "$@"
}

# qmk
qmk() {
    if [[ $@ == 'compile iris' ]]; then
        command qmk compile -kb keebio/iris/rev4 -km anordhoff
    elif [[ $@ == 'flash iris' ]]; then
        command qmk flash -kb keebio/iris/rev4 -km anordhoff
    elif [[ $@ == 'compile yd60' ]]; then
        command qmk compile -kb yd60mq/16led -km anordhoff
    elif [[ $@ == 'flash yd60' ]]; then
        command qmk flash -kb yd60mq/16led -km anordhoff
    else
        command qmk "$@"
    fi
}
