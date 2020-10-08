" source global configuration file
if has("unix")
    let s:uname = system("uname")
    if s:uname == "Linux\n"
        source /usr/share/nvim/sysinit.vim
    endif
endif

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
Plug 'neovim/nvim-lspconfig'
Plug 'prettier/vim-prettier'

" navigation
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/fzf'
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
set number rnu            " relative line numbers
set tabstop=4             " tabs are four columns in width
set softtabstop=4         " insert/delete tab width of whitespace
set shiftwidth=4          " shift by four columns in width
set expandtab             " use spaces instead of tabs
set smartindent           " smart indent
set ignorecase            " case-insensitive searching...
set smartcase             " ...but not if the search contains a capital letter
set noincsearch           " wait to execute search until <enter> is pressed
set hidden                " switch buffers without saving
set splitright            " split vertical windows to the right of current window
set splitbelow            " split horizontal windows below current window
set clipboard=unnamedplus " copy to clipboard

set updatetime=400   " reduce update time from 4s to 400ms
set signcolumn=yes   " always show the sign column
set completeopt=menu " show possible completions in a pmenu

" whitepace preferences
autocmd Filetype json            setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype yaml            setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype html            setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype css             setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype javascript      setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype javascriptreact setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype typescript      setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype typescriptreact setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype terraform       setlocal ts=2 sts=2 sw=2 expandtab

" disable automatic inserting of the current comment leader
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro

" copy to clipboard
if $WAYLAND_DISPLAY != ""
    " wayland clipboard provider that strips carriage returns (wayland/GTK3 issue)
    let g:clipboard = {
        \   'name': 'wayland-strip-carriage',
        \   'copy': {
        \      '+': 'wl-copy --foreground --type text/plain',
        \      '*': 'wl-copy --foreground --type text/plain --primary',
        \    },
        \   'paste': {
        \      '+': {-> systemlist('wl-paste | tr -d "\r"')},
        \      '*': {-> systemlist('wl-paste --primary | tr -d "\r"')},
        \   },
        \   'cache_enabled': 1,
        \ }
else
    if s:uname == "Linux\n"
        " preserve yank when exiting
        autocmd VimLeave * call system("xsel -ib", getreg('+'))
    endif
endif

" ==================== key mappings ==================== "
" leader key
let mapleader = ","

" escape insert mode
inoremap ii <esc>

" yank from the cursor to the end of the line
nnoremap Y y$

" don't overwrite the main register when pasting
xnoremap <silent> <leader>p p:let @+=@0<CR>

" create a new window with an empty file in a vertical split
nnoremap <C-w>m :vnew<CR>

" close quickfix list
nnoremap <leader>q :cclose<CR>

" clear search highlighting
nnoremap <leader>/ :noh<CR>
nnoremap <leader>? :noh<CR>

" ==================== style ==================== "
syntax on
set termguicolors
colorscheme forgotten-dark

" background
hi Normal guibg=#1c1c1c

" trailing whitespace
hi TrailingWhitespace guibg=#77808a
match TrailingWhitespace /\s\+$/

" error/warning messages
hi ErrorMsg guibg=bg guifg=fg
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
    \   'colorscheme': 'lightline',
    \   'active': {
    \     'left': [ [ 'mode', 'paste' ],
    \               [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
    \   },
    \   'component': {
    \     'gitbranch': '%{gitbranch#name()}',
    \     'filename': '%<%{LightlineFilename()}',
    \   },
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
require'lspconfig'.gopls.setup{}
require'lspconfig'.pyls.setup{}
require'lspconfig'.tsserver.setup{}
require'lspconfig'.cssls.setup{}
require'lspconfig'.html.setup{}
require'lspconfig'.jsonls.setup{}
require'lspconfig'.yamlls.setup{}
require'lspconfig'.terraformls.setup{}
EOF

" key mappings
autocmd Filetype go,python,javascript*,typescript* nnoremap <silent> <C-]> <cmd>lua vim.lsp.buf.definition()<CR>
autocmd Filetype go,python,javascript*,typescript* nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
autocmd Filetype go,python,javascript*,typescript* nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
autocmd Filetype go,python,javascript*,typescript* nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
autocmd Filetype go,python,javascript*,typescript* nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
autocmd Filetype go,python,javascript*,typescript* nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
autocmd Filetype go,python,javascript*,typescript* nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
autocmd Filetype go,python,javascript*,typescript* nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
autocmd Filetype go,python,javascript*,typescript* nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>

" completion
autocmd Filetype go,python,javascript*,typescript* setlocal omnifunc=v:lua.vim.lsp.omnifunc

" style
hi LspDiagnosticsHint guifg=#77808a
hi LspDiagnosticsError guifg=#bf5858
hi LspDiagnosticsWarning guifg=#b56f45
hi LspDiagnosticsInformation guifg=#557b9e

" ==================== vim-prettier ==================== "
nnoremap <leader>P :PrettierAsync<CR>

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

" enable preview window with files
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>,
  \   fzf#vim#with_preview(), <bang>0)

" enable preview window with ripgrep
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" floating window with border (https://github.com/neovim/neovim/issues/9718#issuecomment-559573308)
function! CreateCenteredFloatingWindow()
    let width = min([&columns - 4, max([80, &columns - 20])])
    let height = min([&lines - 4, max([20, &lines - 10])])
    let top = ((&lines - height) / 2) - 1
    let left = (&columns - width) / 2
    let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}
    let top = "╭" . repeat("─", width - 2) . "╮"
    let mid = "│" . repeat(" ", width - 2) . "│"
    let bot = "╰" . repeat("─", width - 2) . "╯"
    let lines = [top] + repeat([mid], height - 2) + [bot]
    let s:buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
    call nvim_open_win(s:buf, v:true, opts)
    set winhl=Normal:Floating
    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4
    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    au BufWipeout <buffer> exe 'bw '.s:buf
endfunction

let g:fzf_layout = { 'window': 'call CreateCenteredFloatingWindow()' }

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
let g:go_doc_keywordprg_enabled = 0

" key mappings
autocmd Filetype go nmap <leader>d <plug>(go-decls-dir)

autocmd Filetype go nmap <leader>B :<C-u>call <SID>build_go_files()<CR>
autocmd Filetype go nmap <leader>R <plug>(go-run)
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
