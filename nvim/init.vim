" source global configuration file source $XDG_CONFIG_DIRS/nvim/sysinit.vim
source $XDG_CONFIG_DIRS/nvim/sysinit.vim

" vim-plug setup (:PlugInstall)
call plug#begin(stdpath('data') . '/plugged')
" powerline
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'

" navigation
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/fzf.vim'
Plug 'ludovicchabant/vim-gutentags'

" syntax highlighting
Plug 'joshdick/onedark.vim'
Plug 'sheerun/vim-polyglot'
Plug 'airblade/vim-gitgutter'

" usability
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

" golang
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
call plug#end()

" enable relative line numbers
set rnu
set number

" tab/indent settings
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent

" whitepace preferences
autocmd FileType javascript setlocal ts=2 sts=2 sw=2
autocmd FileType javascriptreact setlocal ts=2 sts=2 sw=2

" copy to clipboard
set clipboard=unnamedplus

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

" enable backspace for previous session
set backspace=indent,eol,start

" show command
set showcmd

" wait to execute search until Enter is pressed
set noincsearch

" ==================== key mappings ==================== "
" map space to leader key (\ by default)
map <Space> <Leader>

" map jk to escape insert mode
inoremap kj <Esc>

" remap split movements
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" clear search highlighting
nnoremap <leader>/ :noh<CR>

" ==================== styling ==================== "
syntax on
set termguicolors
colorscheme onedark
highlight Normal guibg=#1c1c1c

" ==================== fzf ==================== "
nmap <leader>; :Buffers<CR>
nmap <leader>f :Files<CR>
nmap <leader>g :Rg<CR>
nmap <leader>t :Tags<CR>

" ==================== lightline ==================== "
set noshowmode
let g:lightline = {
    \ 'colorscheme': 'onedark',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'gitbranch#name',
    \   'filename': 'LightlineFilename',
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

" ==================== nerdtree ==================== "
" if more than one window and previous buffer was nerdtree, go back to it
autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif

" open nerdtree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" open nerdtree automatically when vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | wincmd p | ene | exe 'NERDTree' argv()[0] | endif

" close vim if the only window left open is nerdtreeree
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" show hidden files
let NERDTreeShowHidden=1

" change key mappings
let NERDTreeMapOpenSplit='s'
let NERDTreeMapOpenVSplit='v'

" ==================== nerdtree-git-plugin ==================== "
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

" ==================== vim-go ==================== "
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <leader>r <Plug>(go-run)
autocmd FileType go nmap <leader>T <Plug>(go-test)
autocmd FileType go nmap <leader>c <Plug>(go-coverage-toggle)

let g:go_list_type = "quickfix"
