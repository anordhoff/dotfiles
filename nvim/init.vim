" source global configuration file source $XDG_CONFIG_DIRS/nvim/sysinit.vim
source $XDG_CONFIG_DIRS/nvim/sysinit.vim

" vim-plug setup (:PlugInstall)
call plug#begin(stdpath('data') . '/plugged')
" powerline
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'

" navigation
Plug 'junegunn/fzf.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" syntax highlighting
Plug 'joshdick/onedark.vim'
Plug 'sheerun/vim-polyglot'
Plug 'airblade/vim-gitgutter'

" usability
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'preservim/nerdcommenter'

" autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" golang
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
call plug#end()

" enable relative line numbers
" set rnu
set number

" tab/indent settings
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent

" whitepace preferences
autocmd FileType javascript setlocal ts=2 sts=2 sw=2
autocmd FileType javascriptreact setlocal ts=2 sts=2 sw=2

" switch buffers without saving
set hidden

" enable backspace for previous session
set backspace=indent,eol,start

" search case sensitivity
set ignorecase
set smartcase

" wait to execute search until <enter> is pressed
set noincsearch

" reduce update time from 4s to 300ms
set updatetime=300

" always show the sign column
set signcolumn=yes

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

" ==================== key mappings ==================== "
" map <space> to leader key (\ by default)
map <space> <leader>

" map jk to escape insert mode
inoremap kj <esc>

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
nmap <leader>: :History<CR>
nmap <leader>f :GFiles<CR>
nmap <leader>F :Files<CR>
nmap <leader>t :BTags<CR>
nmap <leader>T :Tags<CR>
nmap <leader>l :BLines<CR>
nmap <leader>L :Lines<CR>
nmap <leader>g :Rg<CR>
nmap <leader>G :Rg<space>

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
" toggle nerdtree
nmap <leader>n :NERDTreeToggle<CR>
nmap <leader>N :NERDTreeFind<cr>

" show hidden files
let NERDTreeShowHidden = 1

" change key mappings
let NERDTreeMapOpenSplit = 's'
let NERDTreeMapOpenVSplit = 'v'

" ==================== nerdcommenter ==================== "
" yank, comment, and paste
" nnoremap <silent> gz yy:call NERDComment(1, "toggle")<CR>p
" vnoremap <silent> gz Ygv:call NERDComment(1, "toggle")<CR>`>p

" ==================== coc ==================== "
" extensions
" disabled: coc-eslint, coc-prettier
let g:coc_global_extensions = [
    \ 'coc-highlight',
    \ 'coc-json', 'coc-yaml', 'coc-css', 'coc-html', 'coc-python'
    \ ]

" don't pass messages to ins-completion-menu
set shortmess+=c

" use <tab> for trigger completion and navigate to the next complete item
inoremap <silent><expr> <tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<tab>" :
      \ coc#refresh()
inoremap <expr><S-tab> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" colors
highlight CocErrorSign guifg=#e06c75
highlight CocWarningSign guifg=#d19a66
highlight CocInfoSign guifg=#e5c07b
highlight CocHintSign guifg=#abb2bf

" ==================== vim-go ==================== "
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

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
autocmd FileType go nmap <leader>r <plug>(go-run)
autocmd FileType go nmap <leader>T <plug>(go-test)
autocmd FileType go nmap <leader>c <plug>(go-coverage-toggle)

let g:go_list_type = "quickfix"
