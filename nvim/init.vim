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
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ludovicchabant/vim-gutentags'

" usability
Plug 'AndrewRadev/splitjoin.vim' " gS, gJ
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
set number rnu             " relative line numbers
" set tabstop=8              " tabs are eight columns in width
" set softtabstop=4          " insert/delete tab width of whitespace
" set shiftwidth=8           " shift by four columns in width
" set expandtab              " use spaces instead of tabs
" set autoindent
" set smartindent            " smart indent
set ignorecase             " case-insensitive searching...
set smartcase              " ...but not if the search contains a capital letter
set noincsearch            " wait to execute search until <enter> is pressed
set hidden                 " switch buffers without saving
set splitright             " split vertical windows to the right of current window
set splitbelow             " split horizontal windows below current window

set clipboard^=unnamedplus          " copy to clipboard
set signcolumn=yes                  " always show the sign column
set completeopt=menuone,noinsert    " show possible completions in a pmenu; do not auto-insert text
set list lcs=tab:¦\ ,trail:\·       " indentation lines and trailing spaces
set fillchars=vert:\|,stl:-,stlnc:- " vertical and horizontal separators

autocmd Filetype json setlocal sts=2 sw=2 expandtab
" TODO
" whitepace preferences
" autocmd Filetype json            setlocal ts=8 sts=2 sw=2 expandtab
" autocmd Filetype html            setlocal ts=2 sts=2 sw=2 expandtab
" autocmd Filetype css             setlocal ts=2 sts=2 sw=2 expandtab
" autocmd Filetype javascript      setlocal ts=2 sts=2 sw=2 expandtab
" autocmd Filetype javascriptreact setlocal ts=2 sts=2 sw=2 expandtab
" autocmd Filetype typescript      setlocal ts=2 sts=2 sw=2 expandtab
" autocmd Filetype typescriptreact setlocal ts=2 sts=2 sw=2 expandtab

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
hi Search guibg=bg guifg=#8b6a9e
hi Todo guibg=bg guifg=#557b9e

" error/warning messages
hi ErrorMsg guibg=bg guifg=fg
hi WarningMsg guibg=bg guifg=fg

" gutter
hi lineNr guibg=bg
hi cursorLineNr guibg=bg guifg=#8b959e
hi vertSplit guibg=bg guifg=#606060
hi signColumn guibg=bg

" pmenu
hi pmenu guibg=bg guifg=fg
hi pmenuSel guibg=#8b959e

" trailing whitespace
hi Whitespace guifg=bg
hi TrailingWhitespace guifg=fg
2match TrailingWhitespace /\s\+\%#\@<!$/

" lsp diagnostics (nvim-lspconfig)
hi LspDiagnosticsDefaultHint guifg=#77808a
hi LspDiagnosticsDefaultError guifg=#bf5858
hi LspDiagnosticsDefaultWarning guifg=#b56f45
hi LspDiagnosticsDefaultInformation guifg=#557b9e

" ==================== lightline ==================== "
set noshowmode

let g:lightline = {
  \   'colorscheme': 'lightline',
  \   'active': {
  \     'left':  [ [ 'mode', 'paste' ],
  \                [ 'filename', 'readonly', 'modified' ] ],
  \     'right': [ [ 'lineinfo' ],
  \                [ 'filetype', 'percent' ] ]
  \   },
  \   'inactive': {
  \     'left': [],
  \     'right': [],
  \   },
  \   'component': {
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

" ==================== indentLine ==================== "
" support for indents that use spaces
let g:indentLine_fileTypeExclude = ['help', 'markdown', 'text']
let g:indentLine_defaultGroup = 'NonText'
let g:indentLine_showFirstIndentLevel = 1

" ==================== gitgutter ==================== "
" prevent gitgutter from overwriting existing signs
let g:gitgutter_sign_priority = 1

" ==================== nvim-lspconfig ==================== "
lua << EOF
local nvim_lsp = require('lspconfig')

-- TODO: enable borders on completion/omnifunc

-- Disable virtual text on buffer diagnostics
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false
  }
)

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
  local opts = { noremap=true, silent=true }

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  -- Floating window borders enabled where appropriate
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

nvim_lsp['yamlls'].setup{
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  settings = {
    yaml = {
      schemas = {
        ['https://raw.githubusercontent.com/aws-cloudformation/aws-cfn-lint-visual-studio-code/master/schema/all-spec.json'] = 'cloudformation/*'
      },
      format = {
        enable = true
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
" TODO: is this needed now that lua vim.lsp.buf.formatting() exists?
nnoremap <leader>P :PrettierAsync<CR>

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
" show hidden files
let g:NERDTreeShowHidden = 1

" key mappings
let g:NERDTreeMapOpenSplit = 's'
let g:NERDTreeMapOpenVSplit = 'v'

" toggle nerdtree
nmap <leader>n :NERDTreeToggle<CR>
nmap <leader>N :NERDTreeFind<CR>

" ==================== gutentags ==================== "
" dedicated tag directory
" TODO check if dir exists and use default in /etc or something otherswise
let g:gutentags_cache_dir = expand('~/.local/share/nvim/ctags/')

" ==================== vim-obsession ==================== "
nnoremap <leader>o :Obsess<CR>
nnoremap <leader>O :Obsess!<CR>

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

" TODO: fix colors on go-coverage-toggle

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
