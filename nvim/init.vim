" source global configuration file
if has("unix")
  let s:uname = system("uname")
  if s:uname == "Linux\n"
    source /usr/share/nvim/sysinit.vim
  endif
endif

" ==================== plugins ==================== "
call plug#begin(stdpath('data') . '/plugged')

" statusline
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'

" syntax highlighting
Plug 'nightsense/forgotten'
Plug 'Yggdroot/indentLine'
Plug 'sheerun/vim-polyglot'
Plug 'airblade/vim-gitgutter'

" linting/completion
Plug 'neovim/nvim-lspconfig'
Plug 'prettier/vim-prettier'

" navigation
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'PhilRunninger/nerdtree-buffer-ops'
Plug 'ludovicchabant/vim-gutentags'

" usability
Plug 'AndrewRadev/splitjoin.vim'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'

" languages
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'hashivim/vim-terraform'

call plug#end()

" ==================== settings ==================== "
set number nu                   " relative line numbers
set ignorecase                   " case-insensitive searching...
set smartcase                    " ...but not if the search contains a capital letter
set noincsearch                  " wait to execute search until <enter> is pressed
set hidden                       " switch buffers without saving
set splitright                   " split vertical windows to the right of current window
set splitbelow                   " split horizontal windows below current window
set clipboard^=unnamedplus       " copy to clipboard
set signcolumn=yes               " always show the sign column
set completeopt=menuone,noselect " show possible completions in a pmenu; do not auto-select first option
set list lcs=tab:¦\ ,trail:\·    " indentation lines and trailing spaces
set fillchars=vert:\|,stlnc:-    " vertical and horizontal separators

" tab preferences per filetype
autocmd Filetype json setlocal sts=2 sw=2 expandtab

" disable automatic inserting of the current comment leader
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro

" copy to clipboard
if $WAYLAND_DISPLAY != ""
  " wayland clipboard provider that strips carriage returns (wayland/GTK3 issue)
  let g:clipboard = {
    \   'name': 'wayland-strip-carriage',
    \   'copy': {
    \     '+': 'wl-copy --foreground --type text/plain',
    \     '*': 'wl-copy --foreground --type text/plain --primary',
    \   },
    \   'paste': {
    \     '+': {-> systemlist('wl-paste | tr -d "\r"')},
    \     '*': {-> systemlist('wl-paste --primary | tr -d "\r"')},
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
let mapleader = "\<space>"

" prevent clipboard hijacking
inoremap <C-r>+ <C-r><C-r>+
inoremap <C-r>* <C-r><C-r>*

" create a new window with an empty file in a vertical split
nnoremap <C-w>m :vnew<CR>

" clear search highlighting
nnoremap <leader>/ :noh<CR>

" delete trailing whitespace
nnoremap <leader>W :%s/\s\+$//e<CR>

" ==================== style ==================== "
syntax on
set termguicolors
colorscheme forgotten-dark

" background
hi Normal guibg=#1c1c1c

" default status line
hi statusLine guibg=bg guifg=#606060
hi statusLineNC guibg=bg guifg=#606060

" indentation lines
hi NonText guifg=#4d4d4d
match NonText /\t/

" highlighting
hi Todo guibg=bg guifg=#8b6a9e
hi Search guibg=bg guifg=#557b9e

" error/warning messages
hi ErrorMsg guibg=bg guifg=fg
hi WarningMsg guibg=bg guifg=fg

" gutter
hi lineNr guibg=bg
hi cursorLineNr guibg=bg guifg=#8b959e
hi vertSplit guibg=bg guifg=#606060
hi signColumn guibg=bg

" popup menu
hi pmenu guibg=bg guifg=fg
hi pmenuSel guibg=#8b959e

" floating windows
hi FloatBorder guibg=bg guifg=#606060

" trailing whitespace
hi Whitespace guifg=bg
hi TrailingWhitespace guifg=fg
2match TrailingWhitespace /\s\+\%#\@<!$/

" lsp diagnostics
hi LspDiagnosticsDefaultHint guifg=#77808a
hi LspDiagnosticsDefaultError guifg=#bf5858
hi LspDiagnosticsDefaultWarning guifg=#b56f45
hi LspDiagnosticsDefaultInformation guifg=#557b9e

" vim-go
hi goCoverageCovered guifg=#508a50
hi goCoverageUncover guifg=#bf5858

" ==================== lightline ==================== "
set noshowmode

let g:lightline = {
  \   'colorscheme': 'lightline',
  \   'active': {
  \     'left':  [ [ 'mode', 'paste' ],
  \                [ 'gitbranch', 'filename', 'readonly', 'modified' ] ],
  \     'right': [ [ 'lineinfo' ],
  \                [ 'filetype', 'percent' ] ]
  \   },
  \   'inactive': {
  \     'left': [ [ 'gitbranch' ], [] ],
  \     'right': []
  \   },
  \   'component_function': {
  \     'mode': 'LightlineMode',
  \     'paste': 'LightlinePaste',
  \     'gitbranch': 'LightlineGitbranch',
  \     'filename': 'LightlineFilename',
  \     'readonly': 'LightlineReadonly',
  \     'modified': 'LightlineModified',
  \     'lineinfo': 'LightlineLineinfo',
  \     'filetype': 'LightlineFiletype',
  \     'percent': 'LightlinePercent'
  \   }
  \ }

" component functions that hide components from the nerdtree status line
function! LightlineMode()
  return &ft ==# 'nerdtree' ? '' : lightline#mode()
endfunction
function! LightlinePaste()
  return &ft ==# 'nerdtree' ? '' : &paste ? 'PASTE' : ''
endfunction
function! LightlineGitbranch()
  return &ft ==# 'nerdtree' ? gitbranch#name() : ''
endfunction
function! LightlineFilename()
  return &ft ==# 'nerdtree' ? '' : LightlineFilenameFromProjectRoot()
endfunction
function! LightlineReadonly()
  return &ft ==# 'nerdtree' ? '' : &readonly ? 'RO' : ''
endfunction
function! LightlineModified()
  return &ft ==# 'nerdtree' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction
function! LightlineLineinfo()
  return &ft ==# 'nerdtree' ? '' : printf("%3d:%-2d", line('.'), col('.'))
endfunction
function! LightlineFiletype()
  return &ft ==# 'nerdtree' ? '' : &filetype !=# '' ? &filetype : 'no ft'
endfunction
function! LightlinePercent()
  return &ft ==# 'nerdtree' ? '' : printf('%-4s', line('.') * 100 / line('$') . '%')
endfunction

" if the file is part of a git project, return the file path from the root of project
function! LightlineFilenameFromProjectRoot()
  if expand('%:t') ==# ''
    return '[No Name]'
  endif
  let root = fnamemodify(get(b:, 'gitbranch_path'), ':h:h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

" ==================== indentLine ==================== "
" support for indents that use spaces
let g:indentLine_fileTypeExclude = ['help', 'markdown', 'nerdtree', 'text']
let g:indentLine_defaultGroup = 'NonText'
let g:indentLine_showFirstIndentLevel = 1

" ==================== gitgutter ==================== "
" prevent gitgutter from overwriting existing signs
let g:gitgutter_sign_priority = 1

" ==================== nvim-lspconfig ==================== "
lua << EOF
local nvim_lsp = require('lspconfig')

-- Disable virtual text on buffer diagnostics
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline    = false,
    virtual_text = false
  }
)

-- TODO: enable borders on completion/omnifunc
-- Add border to hover windows
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    border = 'rounded'
  }
)

-- Add border to signature help windows
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help, {
    border = 'rounded'
  }
)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings; floating window borders enabled
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD',         '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd',         '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K',          '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi',         '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>',      '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>D',  '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr',         '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>e',  '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = "rounded" })<CR>', opts)
  buf_set_keymap('n', '[d',         '<cmd>lua vim.lsp.diagnostic.goto_prev({ popup_opts = { border = "rounded" }})<CR>', opts)
  buf_set_keymap('n', ']d',         '<cmd>lua vim.lsp.diagnostic.goto_next({ popup_opts = { border = "rounded" }})<CR>', opts)
  buf_set_keymap('n', '<leader>q',  '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<leader>F",  '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'cssls', 'gopls', 'html', 'jsonls', 'pyls', 'terraformls', 'tsserver' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

-- TODO: cloudformation schema throws an error
nvim_lsp['yamlls'].setup{
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  settings = {
    yaml = {
      schemas = {
        ['https://raw.githubusercontent.com/aws-cloudformation/cfn-lint-visual-studio-code/master/schema/all-spec.json'] = '**/{cloudformation,cfn,aws}/**/*.yaml'
      },
      customTags = {
        '!And scalar',
        '!And mapping',
        '!And sequence',
        '!If scalar',
        '!If mapping',
        '!If sequence',
        '!Not scalar',
        '!Not mapping',
        '!Not sequence',
        '!Equals scalar',
        '!Equals mapping',
        '!Equals sequence',
        '!Or scalar',
        '!Or mapping',
        '!Or sequence',
        '!FindInMap scalar',
        '!FindInMap mappping',
        '!FindInMap sequence',
        '!Base64 scalar',
        '!Base64 mapping',
        '!Base64 sequence',
        '!Cidr scalar',
        '!Cidr mapping',
        '!Cidr sequence',
        '!Ref scalar',
        '!Ref mapping',
        '!Ref sequence',
        '!Sub scalar',
        '!Sub mapping',
        '!Sub sequence',
        '!GetAtt scalar',
        '!GetAtt mapping',
        '!GetAtt sequence',
        '!GetAZs scalar',
        '!GetAZs mapping',
        '!GetAZs sequence',
        '!ImportValue scalar',
        '!ImportValue mapping',
        '!ImportValue sequence',
        '!Select scalar',
        '!Select mapping',
        '!Select sequence',
        '!Split scalar',
        '!Split mapping',
        '!Split sequence',
        '!Join scalar',
        '!Join mapping',
        '!Join sequence' 
      }
    }
  }
}
EOF

" ==================== vim-prettier ==================== "
nmap <leader>P :PrettierAsync<CR>

" ==================== fzf ==================== "
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

" enable preview window with ripgrep (and exclude .git/vendor/node_module directories)
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>,
  \   fzf#vim#with_preview(), <bang>0)

" enable preview window with ripgrep (and exclude .git/vendor/node_module directories)
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case --hidden --no-ignore -g "!.git/*" -g "!vendor/*" -g "!node_modules/*" -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" ==================== nerdtree ==================== "
" disable custom nerdtree status line
let g:NERDTreeStatusline = -1

" show hidden files
let g:NERDTreeShowHidden = 1

" key mappings
let g:NERDTreeMapOpenSplit = 's'
let g:NERDTreeMapOpenVSplit = 'v'

" toggle nerdtree
nmap <silent> <leader>n :NERDTreeFocus<CR>
nmap <silent> <leader>N :NERDTreeFind<CR>
nmap <leader><C-n> :NERDTreeClose<CR>

" TODO: fix white box when loading nerdtree for first time

" ==================== gutentags ==================== "
" dedicated tag directory
let g:gutentags_cache_dir = expand('~/.cache/nvim/ctags/')

" ==================== vim-obsession ==================== "
nmap <leader>o :Obsess<CR>
nmap <leader>O :Obsess!<CR>

" ==================== vim-go ==================== "
let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1
let g:go_def_mapping_enabled = 0
let g:go_doc_keywordprg_enabled = 0

" key mappings
autocmd Filetype go nmap <leader>B :<C-u>call <SID>build_go_files()<CR>
autocmd Filetype go nmap <leader>R <plug>(go-run)
autocmd Filetype go nmap <leader>T <plug>(go-test)
autocmd Filetype go nmap <leader>C <plug>(go-coverage-toggle)
autocmd Filetype go command! -bang A  call go#alternate#Switch(<bang>0, 'edit')
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

" ==================== vim-terraform ==================== "
let g:terraform_fmt_on_save=1
