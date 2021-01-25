" plugin-free vim config

" ==================== settings ==================== "
set number rnu             " relative line numbers
set tabstop=4              " tabs are four columns in width
set softtabstop=4          " insert/delete tab width of whitespace
set shiftwidth=4           " shift by four columns in width
set expandtab              " use spaces instead of tabs
set smartindent            " smart indent
set ignorecase             " case-insensitive searching...
set smartcase              " ...but not if the search contains a capital letter
set noincsearch            " wait to execute search until <enter> is pressed
set hidden                 " switch buffers without saving
set splitright             " split vertical windows to the right of current window
set splitbelow             " split horizontal windows below current window
set clipboard^=unnamedplus " copy to clipboard

set backspace=indent,eol,start       " enable backspace for previous session
set hlsearch                         " highlight search results
set showcmd                          " display incomplete commands
set omnifunc=syntaxcomplete#Complete " enable omni completion

" whitepace preferences
autocmd Filetype json            setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype yaml            setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype html            setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype css             setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype javascript      setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype javascriptreact setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype typescript      setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype terraform       setlocal ts=2 sts=2 sw=2 expandtab

" disable automatic inserting of the current comment leader
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro

" enable filetype detection
filetype plugin indent on

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
