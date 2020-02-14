# If not running interactively, don't do anything
[[ $- != *i* ]] && return


# start tmux on shell login
[[ -z "$TMUX" ]] && exec tmux


# aliases
alias ls='ls --color=auto'
alias ll='ls -al'

# neovim
alias vim='nvim'

# kubectl/kubectx/kubens
alias k='kubectl'
alias kctx='kubectx'
alias kns='kubens'


# environment variables
# xdg base directory
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_DATA_DIRS=/usr/local/share:/usr/share
export XDG_CONFIG_DIRS=/etc/xdg

# gpg key
export GPG_TTY=$(tty)

# ~/.local/bin
export PATH=$PATH:$HOME/.local/bin

# golang
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# npm
export PATH=$PATH:$HOME/.npm/bin
export npm_config_prefix=~/.npm

# nvim
export EDITOR=nvim


# functions
# vpn
vpn() {
    systemctl "$@" wg-quick@wg0.service
}

# wifi
wifi() {
    nmcli device wifi "$@"
}

# kubectl/k completion
source <(kubectl completion bash)
complete -F __start_kubectl k


# prompt
#PS1='[\u@\h \W]\$ '
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;33m\]\t\[\033[00m\]:\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
PS1='\e[0;34m[\w]\$\e[m '
