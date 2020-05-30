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
export GOPRIVATE=github.com/criticalstack
export GOPROXY=https://goproxy.dev.cstack.co
export GOSUMDB=off

# npm
export PATH=$PATH:$HOME/.npm/bin
export npm_config_prefix=~/.npm

# disable kubectl interactive mode
export KUBECTX_IGNORE_FZF=1
