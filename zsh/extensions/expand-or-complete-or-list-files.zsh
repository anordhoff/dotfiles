# from https://unix.stackexchange.com/a/32426

function expand-or-complete-or-list-files() {
  if [[ $#BUFFER == 0 ]]; then
    BUFFER="ls "
    CURSOR=3
    zle list-choices
    zle backward-kill-word
  else
    # NOTE: extend expand-multiple-dots.zsh
    # zle expand-or-complete
    zle expand-multiple-dots-then-expand-or-complete
  fi
}

zle -N expand-or-complete-or-list-files
bindkey '^I' expand-or-complete-or-list-files
