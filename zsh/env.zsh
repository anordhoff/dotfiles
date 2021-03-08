# ln -s $HOME/.dotfiles/zsh/env.zsh $XDG_DATA_DIR/oh-my-zsh/custom/.

# ~/.local/bin
export PATH=$PATH:$HOME/.local/bin

# aws
export AWS_PAGER=""

# fzf
export FZF_DEFAULT_OPTS='--height 40%'
export KUBECTX_IGNORE_FZF=1

# golang
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# gpg
export GPG_TTY=$(tty)

# java (lazy loading functions can be found in function.zsh)
export PATH="$PATH:$HOME/.jenv/bin"

# node
[[ "$OSTYPE" == "linux-gnu"* ]] && export NVM_DIR=$XDG_CONFIG_HOME/nvm \
    || export NVM_DIR=$HOME/.nvm
export PATH=:$PATH:$NVM_DIR/versions/node/v13.12.0/bin # decrease startup time
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh" --no-use
