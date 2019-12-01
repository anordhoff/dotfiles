# aliases
# kubectl/kubectx/kubens
alias k='kubectl'
alias kctx='kubectx'
alias kns='kubens'


# environment variables
# gpg key
export GPG_TTY=$(tty)

# ~/.local/bin path
export PATH=$PATH:$HOME/.local/bin

# golang paths
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin


# functions
# kubectl/k completion
source <(kubectl completion bash)
complete -F __start_kubectl k


# prompt
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;33m\]\t\[\033[00m\]:\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
