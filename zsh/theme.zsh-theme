# -*- sh -*- vim:set ft=sh ai et sw=4 sts=4:
# collapse all but current directory
_fishy_collapsed_wd() {
  echo $(pwd | perl -pe '
   BEGIN {
      binmode STDIN,  ":encoding(UTF-8)";
      binmode STDOUT, ":encoding(UTF-8)";
   }; s|^$ENV{HOME}|~|g; s|/([^/.])[^/]*(?=/)|/$1|g; s|/\.([^/])[^/]*(?=/)|/.$1|g
')
}

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[magenta]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[magenta]%}"

PROMPT='%{$fg[blue]%}$(_fishy_collapsed_wd)%{$reset_color%}$(git_prompt_info) %(!.#.$) '
RPROMPT=''
