" source global configuration file
if has("unix")
  let s:uname = system("uname")
  if s:uname == "Linux\n"
    source /usr/share/nvim/sysinit.vim
  endif
endif

" ==================== plugins ==================== "
call plug#begin(stdpath('data') . '/plugged')

Plug 'nvim-treesitter/nvim-treesitter'

" statusline
" Plug 'itchyny/lightline.vim'
" Plug 'itchyny/vim-gitbranch'
" Plug 'nvim-lualine/lualine.nvim'

" syntax highlighting
" Plug 'Yggdroot/indentLine'
" Plug 'sheerun/vim-polyglot'
" Plug 'tpope/vim-sleuth'
Plug 'airblade/vim-gitgutter'
" Plug 'kshenoy/vim-signature'
" Plug 'chentau/marks.nvim'

" linting/completion
Plug 'neovim/nvim-lspconfig'
" Plug 'prettier/vim-prettier'

" navigation
" Plug 'junegunn/fzf'
" Plug 'junegunn/fzf.vim'
" Plug 'preservim/nerdtree' " TODO: replace with nvimtree
" Plug 'PhilRunninger/nerdtree-buffer-ops'
Plug 'ludovicchabant/vim-gutentags'
Plug 'tpope/vim-vinegar'

" Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
" Plug 'nvim-telescope/telescope-fzf-native.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" usability
Plug 'AndrewRadev/splitjoin.vim'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'

" languages
Plug 'fatih/vim-go', {'do': ':GoUpdateBinaries'}
" Plug 'hashivim/vim-terraform'

" colorschemes
Plug 'morhetz/gruvbox'
Plug 'sainnhe/gruvbox-material'

" terminal
" Plug 'voldikss/vim-floaterm'

" Plug 'SirVer/ultisnips'
Plug 'tweekmonster/startuptime.vim'

call plug#end()

" ==================== settings ==================== "
set number nu               " line numbers
set ignorecase              " case-insensitive searching...
set smartcase               " ...but not if the search contains a capital letter
set nohlsearch              " disable search highlighting
set hidden                  " switch buffers without saving
set splitright              " split vertical windows to the right of current window
set splitbelow              " split horizontal windows below current window
set clipboard^=unnamedplus  " copy to clipboard
set signcolumn=yes          " always show the sign column
set fillchars=vert:\|       " vertical and horizontal separators
set scrolloff=5             " keep a minimum of 5 lines above and below the cursor
set nowrap                  " don't wrap text that exceeds width of window
set updatetime=500          " update swap file and signcolumn every 500 ms

" tablines, leading and trailing whitespace characters, and nowrap line markers
" set list
" set listchars=tab:¦\ ,lead:\·,trail:\·,precedes:<,extends:>

" show possible completions in a pmenu; do not auto-select first option; open preview window
" TODO: stabilize the buffer when preview window is opened or closed
set completeopt=menuone,noselect,preview

" close preview window after insert mode completion is done
autocmd InsertLeave * pclose

" disable automatic inserting of the current comment leader
autocmd BufNewFile,BufRead,FileType,OptionSet * set formatoptions-=cro
autocmd BufNewFile,BufRead,FileType,OptionSet * setlocal formatoptions-=cro

" load custom colorscheme
colorscheme colorscheme

" disable syntax highlighting when using vimdiff
if &diff
  syntax off
endif

" enable proper yanking/pasting to/from clipboard on Linux
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

" tab preferences per filetype
" autocmd Filetype json setlocal sts=2 sw=2 expandtab

" ==================== key mappings ==================== "
" leader key
let mapleader = "\<space>"

" keep neovim consistent with vim
nnoremap Y yy

" prevent clipboard hijacking
inoremap <C-r>+ <C-r><C-r>+
inoremap <C-r>* <C-r><C-r>*

" toggle search highlighting
nnoremap <leader>/ :set hlsearch!<CR>

" toggle netrw as a 'project drawer'
" TODO: liststyle=3 only for <leader>n, not -
" TODO: absolute window size, not 30%
" let g:netrw_liststyle = 3
nnoremap <leader>n :30Lexplore<CR>

" maximize the current window
nnoremap <silent> <leader>z :call MaximizeWindowToggle()<CR>
let t:maximized = 0
function! MaximizeWindowToggle()
  if t:maximized
    execute "normal! \<C-w>="
    let t:maximized = 0
  else
    execute "normal! \<C-w>\|\<C-w>_"
    let t:maximized = 1
  endif
endfunction

" get highlight group of word under the cursor
nnoremap <leader>hi :call SynStack()<CR>
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc


" command mode TODO:
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>

" ==================== status line ==================== "
set statusline=\ \[%n\]                     " buffer number
set statusline+=\ \ %f\ \                   " filepath
set statusline+=%{PasteFlag()}              " paste flag
set statusline+=%H%W%R%M                    " help/preview/read-only/modified flags
set statusline+=%=\ \ %c%V\ \ :\ \ %2l\/%L  " byte index, virtual column number; line number
set statusline+=\ \ %y\                     " filetype

augroup statusline
  autocmd!
  " quickfix/location list
  autocmd Filetype qf setlocal statusline=\ %l/%L\ lines%=%q\ 
  " netrw
  autocmd Filetype netrw setlocal statusline=\ \[%n\]\ \ netrw\ \ %{PasteFlag()}%H%W%R%M
  " terminal
  autocmd TermOpen * setlocal statusline=\ \[%n\]\ \ terminal\ \ %{PasteFlag()}%H%W%R%M
augroup END

" set paste flag if paste has been set
function! PasteFlag()
    return &paste == 1 ? 'P' : ''
endfunction

" ==================== terminal ==================== "
" set the preferred editor to neovim
let $VISUAL='nvim'

" open terminal in a horizontal split, vertical split, or tab
nnoremap <leader>ts :20split +te<CR>
nnoremap <leader>tv :80vsplit +te<CR>
nnoremap <leader>tt :tabnew +te<CR>

" exit to normal mode using esc / ctrl-[
tnoremap <C-[> <C-\><c-n>

augroup terminal
  autocmd!
  " enter insert mode automatically
  autocmd TermOpen * startinsert
  " disable line numbers
  autocmd TermOpen * setlocal nonumber norelativenumber
  " hide the sign column
  autocmd TermOpen * setlocal signcolumn=no
  " hide [Process exited 0] when closing terminal
  " NOTE: with this setting, the terminal cannot be used to view results of a process
  autocmd TermClose * execute 'bdelete! ' . expand('<abuf>')
augroup END

" TODO: investate toggling a terminal
" https://github.com/kutsan/dotfiles/blob/d66fdada9bf6a316009c48c1a17e3a78f4f95671/.config/nvim/lua/kutsan/mappings/normal/terminal.lua
" nnoremap <silent> <leader>a :lua require('terminal').toggle()<CR>
" tnoremap <silent> <leader>a <C-\><C-n>:lua require('terminal').toggle()<CR>

" ==================== netrw ==================== "
" nnoremap <leader>n :Lexplore<CR>
" nnoremap <leader>N :Lexplore! %:p:h<CR>

" " prevent errors when moving files
" let g:netrw_keepdir = 0

" " set the size of the netrw window
" let g:netrw_winsize = 30

" " hide the banner
" " let g:netrw_banner = 0

" " enable recursive copies of directories when using the copy command
" let g:netrw_localcopydircmd = 'cp -r'

" ==================== style ==================== "
" if has('termguicolors')
"   set termguicolors
" endif
" set background=dark

" highlight trailing whitespace
" TODO: only works after reloading buffer
" hi Whitespace ctermfg=bg
" hi TrailingWhitespace ctermfg=fg
" 2match TrailingWhitespace /\s\+\%#\@<!$/


" let g:gruvbox_material_disable_italic_comment = 1
" let g:gruvbox_material_sign_column_background = 'none'

" " :h gruvbox-material.txt
" let g:gruvbox_material_better_performance = 1


" let g:gruvbox_contrast_dark = 'soft'
" let g:gruvbox_hls_cursor = 'orange'
" " let g:gruvbox_sign_column = 'none'
" let g:gruvbox_invert_selection = 0



" let g:colors_off_a_little = 1

" colorscheme gruvbox-material
" colorscheme phoenix
" PhoenixPurple


" background
" hi Normal guibg=#2c2c2c
" hi EndOfBuffer guibg=#2c2c2c
" hi LineNr guibg=#2c2c2c
" hi SignColumn guibg=#2c2c2c
" hi NonText guibg=#2c2c2c

" " foreground
" hi LineNr guifg=#666666
" hi Comment guifg=#888888


" " todo/notes
" hi TODO guibg=#2c2c2c
" hi NOTE guibg=#2c2c2c

" " indentation lines
" hi NonText guifg=#666666
" match NonText /\t/

" " highlight trailing whitespace
" hi Whitespace guifg=bg
" hi TrailingWhitespace guifg=fg
" 2match TrailingWhitespace /\s\+\%#\@<!$/




lua << EOF
-- nord.nvim config
-- set nord3_gui_bright = #898D94 and nord4_gui = #B9BFCA in nord.nvim/lua/nord/colors.lua
-- nord3_gui_bright is an even mix of nord4_gui and #303030

-- vim.g.nord_contrast = false
-- vim.g.nord_borders = true
-- vim.g.nord_disable_background = true
-- vim.g.nord_cursorline_transparent = false
-- vim.g.nord_enable_sidebar_background = false
-- vim.g.nord_italic = false

-- load the colorscheme
-- require('nord').set()
-- nord4_gui = "#fff000"
EOF

" floating windows
" hi NormalFloat guibg=bg
" hi VertSplit guifg=#898d94

" " indentation lines
" hi NonText guifg=#898d94
" match NonText /\t/

" " highlight trailing whitespace
" hi Whitespace guifg=bg
" hi TrailingWhitespace guifg=fg
" 2match TrailingWhitespace /\s\+\%#\@<!$/

" " search highlighting
" hi Search guibg=bg guifg=#81a1c1

" " vim-go
" hi goCoverageCovered guifg=#a3be8c
" hi goCoverageUncover guifg=#bf616a








" " default status line
" hi statusLine guibg=bg guifg=#606060
" hi statusLineNC guibg=bg guifg=#606060

" " highlighting
" hi Todo guibg=bg guifg=#8b6a9e
" hi Search guibg=bg guifg=#557b9e

" " error/warning messages
" hi ErrorMsg guibg=bg guifg=fg
" hi WarningMsg guibg=bg guifg=fg

" " gutter
" hi lineNr guibg=bg
" hi cursorLineNr guibg=bg guifg=#8b959e
" hi vertSplit guibg=bg guifg=#606060
" hi signColumn guibg=bg

" " popup menu
" hi pmenu guibg=bg guifg=fg
" hi pmenuSel guibg=#8b959e

" " lsp diagnostics
" hi LspDiagnosticsDefaultHint guifg=#77808a
" hi LspDiagnosticsDefaultError guifg=#bf5858
" hi LspDiagnosticsDefaultWarning guifg=#b56f45
" hi LspDiagnosticsDefaultInformation guifg=#557b9e

" ==================== lightline ==================== "
" set noshowmode

" let g:lightline = {
"   \   'colorscheme': 'lightline',
"   \   'active': {
"   \     'left':  [ [ 'mode', 'paste' ],
"   \                [ 'gitbranch', 'filename', 'readonly', 'modified' ] ],
"   \     'right': [ [ 'lineinfo' ],
"   \                [ 'filetype', 'percent' ] ]
"   \   },
"   \   'inactive': {
"   \     'left': [ [ 'gitbranch' ], [] ],
"   \     'right': []
"   \   },
"   \   'component_function': {
"   \     'mode': 'LightlineMode',
"   \     'paste': 'LightlinePaste',
"   \     'gitbranch': 'LightlineGitbranch',
"   \     'filename': 'LightlineFilename',
"   \     'readonly': 'LightlineReadonly',
"   \     'modified': 'LightlineModified',
"   \     'lineinfo': 'LightlineLineinfo',
"   \     'filetype': 'LightlineFiletype',
"   \     'percent': 'LightlinePercent'
"   \   }
"   \ }

" " component functions that hide components from the nerdtree status line
" function! LightlineMode()
"   return &ft ==# 'nerdtree' ? '' : lightline#mode()
" endfunction
" function! LightlinePaste()
"   return &ft ==# 'nerdtree' ? '' : &paste ? 'PASTE' : ''
" endfunction
" function! LightlineGitbranch()
"   return &ft ==# 'nerdtree' ? gitbranch#name() : ''
" endfunction
" function! LightlineFilename()
"   return &ft ==# 'nerdtree' ? '' : LightlineFilenameFromProjectRoot()
" endfunction
" function! LightlineReadonly()
"   return &ft ==# 'nerdtree' ? '' : &readonly ? 'RO' : ''
" endfunction
" function! LightlineModified()
"   return &ft ==# 'nerdtree' ? '' : &modified ? '+' : &modifiable ? '' : '-'
" endfunction
" function! LightlineLineinfo()
"   return &ft ==# 'nerdtree' ? '' : printf("%3d:%-2d", line('.'), col('.'))
" endfunction
" function! LightlineFiletype()
"   return &ft ==# 'nerdtree' ? '' : &filetype !=# '' ? &filetype : 'no ft'
" endfunction
" function! LightlinePercent()
"   return &ft ==# 'nerdtree' ? '' : printf('%-4s', line('.') * 100 / line('$') . '%')
" endfunction

" " if the file is part of a git project, return the file path from the root of project
" function! LightlineFilenameFromProjectRoot()
"   if expand('%:t') ==# ''
"     return '[No Name]'
"   endif
"   let root = fnamemodify(get(b:, 'gitbranch_path'), ':h:h')
"   let path = expand('%:p')
"   if path[:len(root)-1] ==# root
"     return path[len(root)+1:]
"   endif
"   return expand('%')
" endfunction

" ==================== lualine ==================== "
" lua << END
" require'lualine'.setup {
"   options = {
"     icons_enabled = false,
"     component_separators = '|',
"     section_separators = '',
"     disabled_filetypes = {},
"     always_divide_middle = false,
"   },
"   sections = {
"     lualine_a = {'mode'},
"     lualine_b = {},
"     lualine_c = {'branch', 'filename'},
"     lualine_x = {'filetype', 'progress'},
"     lualine_y = {},
"     lualine_z = {'location'}
"   },
"   inactive_sections = {
"     lualine_a = {},
"     lualine_b = {},
"     lualine_c = {'filename'},
"     lualine_x = {'location'},
"     lualine_y = {},
"     lualine_z = {}
"   },
"   tabline = {},
"   extensions = {}
" }
" END

" ==================== indentLine ==================== "
" support for indents that use spaces
let g:indentLine_fileTypeExclude = ['help', 'markdown', 'nerdtree', 'text']
let g:indentLine_defaultGroup = 'NonText'
let g:indentLine_showFirstIndentLevel = 1

" ==================== gitgutter ==================== "
" prevent gitgutter from overwriting existing signs
let g:gitgutter_sign_priority = 1
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '•'
let g:gitgutter_sign_removed = '_'

" ==================== vim-signature ==================== "
" TODO: change color of mark in gutter if lsp detects error/warning/etc
" hi SignatureMarkText guifg=fg

" ==================== marks.nvim ==================== "
" lua << EOF
" require'marks'.setup {
"   default_mappings = false,
"   signs = true,
"   mappings = {}
" }
" EOF

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
local servers = { 'cssls', 'gopls', 'html', 'jsonls', 'pylsp', 'terraformls', 'tsserver' }
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
" nmap <leader>P :PrettierAsync<CR>

" ==================== fzf ==================== "
" nmap <leader>fb :Buffers<CR>
" nmap <leader>ff :Files<CR>
" nmap <leader>ft :Tags<CR>
" nmap <leader>fl :BLines<CR>
" nmap <leader>fg :Rg<CR>
" nmap <leader>fG :Rg<space>

" " remap split keys
" let g:fzf_action = {
"   \ 'ctrl-t': 'tab split',
"   \ 'ctrl-s': 'split',
"   \ 'ctrl-v': 'vsplit' }

" " enable preview window with ripgrep (and exclude .git/vendor/node_module directories)
" command! -bang -nargs=? -complete=dir Files
"   \ call fzf#vim#files(<q-args>,
"   \   fzf#vim#with_preview(), <bang>0)

" " enable preview window with ripgrep (and exclude .git/vendor/node_module directories)
" command! -bang -nargs=* Rg
"   \ call fzf#vim#grep(
"   \   'rg --column --line-number --no-heading --color=always --smart-case --hidden --no-ignore -g "!.git/*" -g "!vendor/*" -g "!node_modules/*" -- '.shellescape(<q-args>), 1,
"   \   fzf#vim#with_preview(), <bang>0)

" ==================== nerdtree ==================== "
" " TODO: open nerdtree on right so vim buffer doesn't move
" " disable custom nerdtree status line
" let g:NERDTreeStatusline = -1

" " show hidden files
" let g:NERDTreeShowHidden = 1

" " key mappings
" let g:NERDTreeMapOpenSplit = 's'
" let g:NERDTreeMapOpenVSplit = 'v'

" " toggle nerdtree
" nmap <silent> <leader>n :NERDTreeFocus<CR>
" nmap <silent> <leader>N :NERDTreeFind<CR>
" nmap <leader><C-n> :NERDTreeClose<CR>

" " TODO: fix white box when loading nerdtree for first time

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
" TODO: consider using <leader>gb for go build, <leader>gr for go run, etc.
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
" let g:terraform_fmt_on_save=1


" ==================== vim-telescope ==================== "
lua << EOF
-- TODO: layout, style
require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    prompt_prefix = ' $ ',
    preview = {
      treesitter = false
    },
    -- not sure about color_devicons
    color_devicons = false,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        -- ["<C-x>"] = false,
        ["<C-s>"] = "select_horizontal"
      },
      n = {
        -- ["<C-x>"] = false,
        ["<C-s>"] = "select_horizontal"
      }
    }
    -- file_ignore_patterns = {
    --   "^scratch/"
    -- },
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
    buffers = {}
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
}

-- lua require("telescope.builtin").find_files({hidden=true, layout_config={prompt_position="top"}})
-- nnoremap <Leader>pp :lua require'telescope.builtin'.planets{}<CR>

--  buf_set_keymap('n', 'gD',         '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
-- nnoremap <Leader>tb <cmd>Telescope buffers<CR>
-- nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
EOF

" live grep needs to show lines in .gitignore files, hide specific files (ie .git)
nnoremap <Leader>ff <cmd>lua require('telescope.builtin').find_files{hidden = true, no_ignore = true}<CR>
nnoremap <Leader>fg <cmd>lua require('telescope.builtin').live_grep{no_ignore = true}<CR>
nnoremap <Leader>fb <cmd>lua require('telescope.builtin').buffers{}<CR>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <Leader>fc <cmd>lua require('telescope.builtin').command_history{}<CR>
nnoremap <Leader>fr <cmd>lua require('telescope.builtin').registers{}<CR>

" git TODO: keep these?
" nnoremap <Leader>fgc :lua require'telescope.builtin'.git_commits{}<CR>
" nnoremap <Leader>fgbc :lua require'telescope.builtin'.git_bcommits{}<CR>
" nnoremap <Leader>fgb :lua require'telescope.builtin'.git_branches{}<CR>
" nnoremap <Leader>fgs :lua require'telescope.builtin'.git_status{}<CR>
" nnoremap <Leader>fgstas :lua require'telescope.builtin'.git_stash{}<CR>

" treesitter TODO: does nothing until I setup treesitter
" nnoremap <Leader>ftrees :lua require'telescope.builtin'.git_status{}<CR>

" :marks, :reg TODO: maybe keep?
" nnoremap <Leader>tm :lua require'telescope.builtin'.marks{}<CR>

" might already exist TODO: maybe keep?
" nnoremap <Leader>fj :lua require'telescope.builtin'.jumplist{}<CR>
" nnoremap <Leader>fta :lua require'telescope.builtin'.tagstack{}<CR>

" TODO: maybe keep?
" nnoremap <Leader>ftree :lua require'telescope.builtin'.file_browser{dir_icon = '-', hidden = true}<CR>
" nnoremap <Leader>fref :lua require'telescope.builtin'.lsp_references{}<CR>
" nnoremap <Leader>fdef :lua require'telescope.builtin'.lsp_definitions{}<CR>
" nnoremap <Leader>fi :lua require'telescope.builtin'.lsp_implementations{}<CR>
" nnoremap <Leader>fd :lua require'telescope.builtin'.diagnostics{}<CR>


" old fzf commands
" nmap <leader>fb :Buffers<CR>
" nmap <leader>ff :Files<CR>
" nmap <leader>ft :Tags<CR>
" nmap <leader>fl :BLines<CR>
" nmap <leader>fg :Rg<CR>
" nmap <leader>fG :Rg<space>
