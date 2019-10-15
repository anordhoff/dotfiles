" vim-plug setup
" :PlugInstall to install plugins
call plug#begin('~/.vim/plugged')
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'joshdick/onedark.vim'
Plug 'sheerun/vim-polyglot'
Plug 'itchyny/lightline.vim'
call plug#end()

" enable line numbers
set number

" tab/indent settings
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent

" copy to clipboard
set clipboard=unnamedplus
autocmd VimLeave * call system("xsel -ib", getreg('+'))

" enable backspace for previous session
set backspace=indent,eol,start

" remap split movements
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" colors
syntax on
set termguicolors
colorscheme onedark

" this is only necessary if you use 'set termguicolors' (tmux)
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" lightline
set laststatus=2
set noshowmode
let g:lightline = {'colorscheme': 'onedark'}

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe (ultisnips)
"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window (ultisnips)
"let g:UltiSnipsEditSplit="vertical"

" nerdtree ignores
let NERDTreeIgnore=['\~$', '\.pyc', '\.swp$', '\.git', '\.hg', '\.svn',
      \ '\.ropeproject', '\.o', '\.bzr', '\.ipynb_checkpoints$',
      \ '__pycache__',
      \ '\.egg$', '\.egg-info$', '\.tox$', '\.idea$', '\.sass-cache',
      \ '\.env$', '\.env[0-9]$', '\.coverage$', '\.tmp$', '\.gitkeep$',
      \ '\.coverage$', '\.webassets-cache$', '\.vagrant$', '\.DS_Store',
      \ '\.env-pypy$']

