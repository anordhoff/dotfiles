# ln -s $HOME/.dotfiles/zsh/alias.zsh $XDG_DATA_DIR/oh-my-zsh/custom/.

# expand aliased arguments
alias watch='watch -n 1 '

# git
alias   g='git'
alias  ga='git add'
alias  gb='git branch'
alias  gc='git commit'
alias gco='git checkout'
alias  gd='git diff'
alias  gl='git log'
alias  gp='git pull'
alias gpu='git push'
alias  gr='git reset'
alias grb='git rebase'
alias  gs='git status'
alias gst='git stash'
alias gsh='git show'

# kubectl
alias k='kubectl'

# kubectx/kubens
alias kctx='kubectx'
alias kns='kubens'

# neovim
alias e='nvim'

# wget
alias wget='wget --hsts-file="$XDG_CACHE_HOME/wget-hsts"'

# wifi
alias wifi='nmcli device wifi'
