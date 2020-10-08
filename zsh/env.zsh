# xdg base directory
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    export XDG_CONFIG_HOME=$HOME/.config
    export XDG_CACHE_HOME=$HOME/.cache
    export XDG_DATA_HOME=$HOME/.local/share
    export XDG_DATA_DIRS=/usr/local/share:/usr/share
    export XDG_CONFIG_DIRS=/etc/xdg
fi

# gpg key
export GPG_TTY=$(tty)

# ~/.local/bin
export PATH=$PATH:$HOME/.local/bin

# golang
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    export GOPRIVATE=github.com/criticalstack
    export GOPROXY=https://goproxy.dev.cstack.co
    export GOSUMDB=off
fi

# node
export PATH=:$PATH:~/.nvm/versions/node/v13.12.0/bin # decrease startup time
export NVM_DIR=~/.nvm
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh" --no-use

# java (lazy loading functions can be found in function.zsh)
export PATH="$PATH:$HOME/.jenv/bin"

# fzf
export FZF_DEFAULT_OPTS='--height 40%'

# disable kubectl interactive mode
export KUBECTX_IGNORE_FZF=1
