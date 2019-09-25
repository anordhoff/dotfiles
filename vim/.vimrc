syntax on

" This is only necessary if you use "set termguicolors".
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" fixes glitch? in colors when using vim with tmux
set background=dark
set t_Co=256

set termguicolors

" tab/indent settings
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent

" enable line numbers
set number

" enable mouse features
" set mouse=a

" copy to clipboard
set clipboard=unnamedplus
autocmd VimLeave * call system("xsel -ib", getreg('+'))

" enable backspace for previous session
set backspace=indent,eol,start
