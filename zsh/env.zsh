# ln -s $HOME/.dotfiles/zsh/env.zsh $XDG_DATA_DIR/oh-my-zsh/custom/.

# ~/.local/bin
export PATH=$PATH:$HOME/.local/bin

# fzf
export FZF_DEFAULT_OPTS='--height 40%'

# golang
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# gpg
export GNUPGHOME=$XDG_CONFIG_HOME/gnupg
export GPG_TTY=$(tty)

# java (lazy loading functions can be found in function.zsh)
export PATH="$PATH:$HOME/.jenv/bin"

# kubectl - disable interactive mode
export KUBECTX_IGNORE_FZF=1

# less
[[ -d "$XDG_CACHE_HOME/less" ]] || mkdir -p $XDG_CACHE_HOME/less
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"
export LESSKEY="$XDG_CONFIG_HOME/less/lesskey"

# minikube
export MINIKUBE_HOME=$XDG_CONFIG_HOME/minikube

# node
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
[[ "$OSTYPE" == "linux-gnu"* ]] && export NVM_DIR=$XDG_CONFIG_HOME/nvm \
    || export NVM_DIR=~/.nvm
export PATH=:$PATH:$NVM_DIR/versions/node/v13.12.0/bin # decrease startup time
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh" --no-use
