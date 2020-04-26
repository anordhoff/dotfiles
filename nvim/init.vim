" source global configuration file
source /usr/share/nvim/sysinit.vim

" ==================== plugins ==================== "
" vim-plug setup (:PlugInstall)
call plug#begin(stdpath('data') . '/plugged')

" statusline
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'

" syntax highlighting
Plug 'nightsense/forgotten'
Plug 'sheerun/vim-polyglot'
Plug 'airblade/vim-gitgutter'

" linting/completion
Plug 'neovim/nvim-lsp'

" navigation
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/fzf.vim'
Plug 'ludovicchabant/vim-gutentags'

" usability
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'anordhoff/vim-commentary' " fork of tpope/vim-commentary
Plug 'AndrewRadev/splitjoin.vim'

" languages
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()

" ==================== settings ==================== "
set number                     " enable line numbers
set number rnu                 " relative line numbers
set tabstop=4                  " tabs are four columns in width
set shiftwidth=4               " shift by four columns in width
set softtabstop=4              " insert/delete tab width of whitespace
set expandtab                  " use spaces instead of tabs
set smartindent                " smart indent
set hidden                     " switch buffers without saving
set backspace=indent,eol,start " enable backspace for previous session
set ignorecase                 " insensitive case searching...
set smartcase                  " ...but not if the search begins with upper case letter
set noincsearch                " wait to execute search until <enter> is pressed
set updatetime=400             " reduce update time from 4s to 400ms
set signcolumn=yes             " always show the sign column
set splitright                 " split vertical windows to the right of current windoww
set splitbelow                 " split horizontal windows below current windows
set clipboard=unnamedplus      " copy to clipboard
set completeopt=menu           " show possible completions in a pmenu

" whitepace preferences
autocmd Filetype html setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype javascriptreact setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype typescript setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype terraform setlocal ts=2 sts=2 sw=2 expandtab

" disable automatic inserting of the current comment leader
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro

" don't overwrite the main register when pasting with 'p'
xnoremap <silent> p p:let @+=@0<CR>

" send deleted text to the black hole register
" TODO: better way to handle this?
" nnoremap d "_d
" vnoremap d "_d
" nnoremap D "_D
" vnoremap D "_D
" nnoremap c "_c
" vnoremap c "_c
" nnoremap C "_C
" vnoremap C "_C

" wayland clipboard provider that strips carriage returns (wayland/GTK3 issue)
let g:clipboard = {
    \   'name': 'wayland-strip-carriage',
    \   'copy': {
    \      '+': 'wl-copy --foreground --type text/plain',
    \      '*': 'wl-copy --foreground --type text/plain --primary',
    \    },
    \   'paste': {
    \      '+': {-> systemlist('wl-paste --no-newline | tr -d "\r"')},
    \      '*': {-> systemlist('wl-paste --no-newline --primary | tr -d "\r"')},
    \   },
    \   'cache_enabled': 1,
    \ }

" ==================== key mappings ==================== "
let mapleader = ","

" map kj to escape insert mode
inoremap kj <esc>

" yank from the cursor to the end of the line
nnoremap Y y$

" swap between buffers
" noremap <leader>j :bn<CR>
" noremap <leader>k :bp<CR>

" create a new window with an empty file in a vertical split
nnoremap <C-w>m :vnew<CR>

" close quickfix list
nnoremap <leader>a :cclose<CR>

" clear search highlighting
nnoremap <leader>/ :noh<CR>
nnoremap <leader>? :noh<CR>

" ==================== style ==================== "
syntax on
set termguicolors
colorscheme forgotten-dark

" background
hi Normal guibg=#1c1c1c

" error/warning messages
hi ErrorMsg guibg=bg
hi WarningMsg guibg=bg guifg=fg

" default status line
hi statusLine guibg=bg guifg=fg
hi statusLineNC guibg=bg guifg=fg

" gutter
hi lineNr guibg=bg
hi cursorLineNr guibg=bg guifg=#8b959e
hi vertSplit guibg=bg guifg=#303030
hi signColumn guibg=bg

" pmenu
hi pmenu guibg=#1d242b guifg=#a3acb5
hi pmenuSel guibg=#8b959e

" ==================== lightline ==================== "
set noshowmode

let g:lightline = {
    \ 'colorscheme': 'lightline',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component': {
    \   'gitbranch': '%{gitbranch#name()}',
    \   'filename': '%<%{LightlineFilename()}',
    \ },
    \ }

function! LightlineFilename()
  let root = fnamemodify(get(b:, 'gitbranch_path'), ':h:h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

" ==================== gitgutter ==================== "
" prevent gitgutter from overwriting existing signs
let g:gitgutter_sign_priority = 1

" ==================== nvim-lsp ==================== "
:lua << EOF
require'nvim_lsp'.gopls.setup{}
require'nvim_lsp'.pyls.setup{}
EOF

" key mappings
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>

" completion
autocmd Filetype go setlocal omnifunc=v:lua.vim.lsp.omnifunc
autocmd Filetype python setlocal omnifunc=v:lua.vim.lsp.omnifunc

" style
hi LspDiagnosticsError guifg=#bf5858
hi LspDiagnosticsErrorSign guifg=#bf5858
hi LspDiagnosticsWarning guifg=#616b75
hi LspDiagnosticsWarningSign guifg=#616b75

" ==================== nerdtree ==================== "
" show hidden files
let g:NERDTreeShowHidden = 1

" key mappings
let g:NERDTreeMapOpenSplit = 's'
let g:NERDTreeMapOpenVSplit = 'v'

" toggle nerdtree
nmap <leader>n :NERDTreeToggle<CR>
nmap <leader>N :NERDTreeFind<CR>

" ==================== fzf ==================== "
" key mappings
nmap <leader>b :Buffers<CR>
nmap <leader>f :Files<CR>
nmap <leader>t :Tags<CR>
nmap <leader>l :BLines<CR>
nmap <leader>g :Rg<CR>
nmap <leader>G :Rg<space>

" remap split keys
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

" colors
let g:fzf_colors = {
  \ 'bg': ['bg', 'CursorLine'],
  \ 'border': ['fg', 'NonText'] }

" enable preview window with files
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>,
  \   fzf#vim#with_preview(), <bang>0)

" enable preview window with ripgrep
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" ==================== gutentags ==================== "
" dedicated tag directory
let g:gutentags_cache_dir = expand('~/.local/share/nvim/ctags/')

" ==================== vim-go ==================== "
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_list_type = "quickfix"
let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1
let g:go_def_mapping_enabled = 0

" map <C-n> :cnext<CR>
" map <C-p> :cprevious<CR>
" nnoremap <leader>a :cclose<CR>

autocmd Filetype go nmap <leader>d <plug>(go-decls-dir)

autocmd Filetype go nmap <leader>B :<C-u>call <SID>build_go_files()<CR>
autocmd Filetype go nmap <leader>R <Plug>(go-run)
autocmd Filetype go nmap <leader>T <plug>(go-test)
autocmd Filetype go nmap <leader>C <plug>(go-coverage-toggle)
autocmd Filetype go nmap <leader>I <plug>(go-info)
autocmd Filetype go nmap <leader>D <plug>(go-doc)
autocmd Filetype go nmap <leader>F <plug>(go-doc-browser)

autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction
