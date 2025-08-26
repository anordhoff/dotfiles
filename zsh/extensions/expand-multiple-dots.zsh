# https://github.com/parkercoates/dotfiles/blob/master/.zsh/expand-multiple-dots.zsh
# from http://stackoverflow.com/a/41420448/4757

function expand-multiple-dots() {
  local MATCH
  if [[ $LBUFFER =~ '(^| )\.\.\.+' ]]; then
    LBUFFER=$LBUFFER:fs%\.\.\.%../..%
  fi
}

function expand-multiple-dots-then-expand-or-complete() {
  zle expand-multiple-dots
  zle expand-or-complete
}

function expand-multiple-dots-then-accept-line() {
  zle expand-multiple-dots
  zle accept-line
}

zle -N expand-multiple-dots
zle -N expand-multiple-dots-then-expand-or-complete
zle -N expand-multiple-dots-then-accept-line

# overridden by expand-or-complete-or-list-files.zsh
# bindkey '^I' expand-multiple-dots-then-expand-or-complete
bindkey '^M' expand-multiple-dots-then-accept-line
