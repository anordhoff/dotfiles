" --------------------------------------
" settings
" --------------------------------------
set number             " line numbers
set noincsearch        " don't execute search until hitting enter
set noshowmode         " hide the mode from the bottom row
set ignorecase         " case-insensitive searching...
set smartcase          " ...but not if the search contains a capital letter
set splitright         " split vertical windows to the right of current window
set splitbelow         " split horizontal windows below current window
set foldnestmax=1      " limit to 1 nested fold
set foldlevel=1        " don't automatically close folds
set fillchars=vert:\|  " use the pipe symbol as a vertical separator
set textwidth=79       " wrap lines at 79 characters when formatting
set scrolloff=2        " keep a minimum of 2 lines above and below the cursor
set sidescrolloff=8    " keep a minimum of 8 columns before & after the cursor
set shell=/bin/zsh\ -i " interactive command mode shell (for aliases)

" use spaces by default
set tabstop=2
set shiftwidth=2
set expandtab

" make line wrapping look nicer, but don't wrap by default
set nowrap
set linebreak
set breakindent
set showbreak=\ ..\  " trailing whitespace

" show possible completions in a pmenu; insert longest common text of matches
set completeopt=menu,longest
set pumheight=10
set shortmess+=c

" use a wildmenu for command line completion
set wildoptions=tagfile
set wildmode=longest:full,full
set wildignorecase

" load custom colorscheme
colorscheme colorscheme

" disable automatic line wrapping for non-comment text; disable insertion of
" the current comment leader when creating a new line
augroup formatoptions
  autocmd!
  autocmd BufNewFile,BufRead,FileType,OptionSet * set fo-=t fo-=r fo-=o
  autocmd BufNewFile,BufRead,FileType,OptionSet * setlocal fo-=t fo-=r fo-=o
augroup END

" enable spellchecking for text files, markdown, and git commit messages
augroup spellcheck
  autocmd!
  autocmd FileType text,markdown,gitcommit setlocal spell
augroup END

" --------------------------------------
" keymaps
" --------------------------------------

" leader key
let mapleader = "\<space>"

" prevent clipboard hijacking
inoremap <C-r>+ <C-r><C-r>+
inoremap <C-r>* <C-r><C-r>*

" quickly run a command in a new terminal buffer
nnoremap z<space> :term<space>

" lvimgrep (simply use :vim for vimgrep)
nnoremap g<space> :lvimgrep  %<left><left>

" edit
set wildcharm=<C-z>
nnoremap <leader>e :e **/*<C-z><S-Tab>
nnoremap <leader>b :ls<CR>:b<Space>

" toggle the quickfix list window
nnoremap <silent> <leader>q :call init#togglequickfixlist()<CR>

" toggle the location list window
nnoremap <silent> <leader>l :call init#togglelocationlist()<CR>

" maximize (toggle) the current window (NOTE: overrides default mappings)
nnoremap <silent> <C-w>z <C-w>\|<C-w>_
nnoremap <silent> <C-w><C-z> <C-w>\|<C-w>_

" toggle sharing mode (turns on cursorline/cursorcolumn for active buffer)
command Share :call init#sharing(1)
command Noshare :call init#sharing(0)

" get highlight group under the cursor
command Hi :call init#syngroup()

" clear the specified register (:wshada! to persist changes)
command! -nargs=1 Clear :call init#clearregisters(<q-args>)

" trigger omni completion
inoremap <expr> <Tab> pumvisible() ? '<C-n>' :
  \ getline('.')[col('.') - 2] !~ '^\s\?$' ? '<C-x><C-o>' : '<Tab>'
inoremap <expr> <S-Tab> pumvisible() ? '<C-p>' :
  \ getline('.')[col('.') - 2] !~ '^\s\?$' ? '<C-x><C-o>' : '<S-Tab>'


" --------------------------------------
" statusline
" --------------------------------------

set statusline=\ \[%n\]                      " buffer number
set statusline+=\ \ %f                       " filepath
set statusline+=\ \ %{NopluginFlag()}        " session flag
set statusline+=%{SessionFlag()}             " session flag
set statusline+=%{PasteFlag()}               " paste flag
set statusline+=%H%W%R%M                     " help/preview/read-only/modified flags
set statusline+=%=\ \ \ %c%V\ \ :\ \ %2l\/%L " byte index, virtual column number; line number
set statusline+=%{Filetype()}                " filetype

augroup statusline
  autocmd!
  autocmd Filetype qf setlocal statusline=\ \[%n\]\ \ %l/%L\ lines%=%q\  " trailing whitespace
  autocmd Filetype netrw setlocal statusline=\ \[%n\]\ \ %l/%L\ lines%=\[netrw\]\  " trailing whitespace
  autocmd TermOpen * setlocal statusline=\ \[%n\]\ \ terminal\ \ %{NopluginFlag()}%{PasteFlag()}%H%W%R%M\ \ %{TerminalMode()}
augroup END

" correct padding when there is no filetype
function Filetype()
  return &filetype == '' ? ' ' : '  [' . &filetype . '] '
endfunction

" noplugin flag if running with --noplugin set
function NopluginFlag()
  return !&loadplugins ? 'NP' : ''
endfunction

" session flag if a session is being recorded or is paused
function SessionFlag()
  if &loadplugins && exists('*ObsessionStatus')
    return ObsessionStatus('S', 's')
  endif
  return ''
endfunction

" set paste flag if paste has been set
function PasteFlag()
  if !&paste
    return ''
  endif
  if &loadplugins && exists('v:this_session')
    return ',P'
  elseif !&loadplugins
    return ',P'
  else
    return 'P'
  endif
endfunction

" set 'insert' flag if terminal buffer is in 'terminal' mode
function TerminalMode()
  return mode() == 't' ? 'insert' : ''
endfunction


" --------------------------------------
" tabline
" --------------------------------------

set tabline=%!TabLine()

function TabLine()
  let l:line = ''
  for l:tab in range(tabpagenr('$'))
    if l:tab + 1 == tabpagenr()
      let l:line .= '%#TabLineSel#'
    else
      let l:line .= '%#TabLine#'
    endif
    let l:line .= ' %{TabLabel(' . (l:tab + 1) . ')} '
  endfor
  let l:line .= '%#TabLineFill#%T'
  return l:line
endfunction

function TabLabel(n)
  let l:winnr = tabpagewinnr(a:n)
  let l:buflist = tabpagebuflist(a:n)
  let l:bufname = bufname(l:buflist[l:winnr - 1])
  let l:filetype = getbufvar(l:buflist[l:winnr - 1], '&filetype')
  if l:bufname == ''
    return '[No Name]'
  elseif l:bufname =~ '/nvim/runtime/doc/'
    return 'help'
  elseif l:filetype == 'netrw'
    return 'netrw'
  elseif l:filetype == 'dirvish'
    return 'dirvish'
  elseif l:bufname =~ '^term://'
    return 'terminal'
  else
    return l:bufname
  endif
endfunction


" --------------------------------------
" netrw
" --------------------------------------

if &loadplugins
  " set the absolute size of netrw windows
  let g:netrw_winsize = -30

  " hide the informational banner
  let g:netrw_banner = 0

  " tree style listing
  let g:netrw_liststyle = 3

  " toggle netrw as a project drawer
  nnoremap <silent> <leader>t :Lexplore<CR>
endif


" --------------------------------------
" notes
" --------------------------------------

" notes directory
let g:notesdir = '~/notes/misc.md'

" toggle the notebook
nnoremap <silent> <leader>n :call init#togglenotes(g:notesdir)<CR>

" prevent notes from being added to the buffer list
augroup notes
  autocmd!
  autocmd BufNewFile,BufRead ~/notes/*.txt,~/notes/*.md setlocal nobuflisted
augroup END


" --------------------------------------
" terminal
" --------------------------------------

" set the preferred editor to use the current session's RPC server
let $VISUAL="nvim --server " . v:servername . " --remote"
let $EDITOR="nvim --server " . v:servername . " --remote"

" exit to normal mode using ctrl-[ or escape
tnoremap <C-[> <C-\><C-n>
tnoremap <esc> <C-\><C-n>

" open terminal in a horizontal or vertical split
nnoremap <silent> <A-s> :call init#toggleterm(0)<CR>
nnoremap <silent> <A-v> :call init#toggleterm(1)<CR>

" toggle terminal without leaving terminal insert mode
tnoremap <silent> <A-s> <C-\><C-n>:call init#toggleterm(0)<CR>
tnoremap <silent> <A-v> <C-\><C-n>:call init#toggleterm(1)<CR>

" use ctrl-r to access registers in terminal insert mode
tnoremap <expr> <C-r> '<C-\><C-N>"'.nr2char(getchar()).'pi'

augroup terminal
  autocmd!
  " enter insert mode automatically
  autocmd TermOpen * startinsert
  " disable line numbers
  autocmd TermOpen * setlocal nonumber norelativenumber
  " hide the sign column
  autocmd TermOpen * setlocal signcolumn=no
  " prevent the terminal from being added to the buffer list
  autocmd TermOpen * setlocal nobuflisted
augroup END


" --------------------------------------
" jobfiles
" --------------------------------------

runtime job.vim


" --------------------------------------
" plugins
" --------------------------------------

if &loadplugins
  " native plugins
  packadd cfilter

  " neovim plugins
  lua require('impatient')
  lua require('anordhoff.leap')
  lua require('anordhoff.lspconfig')
  lua require('anordhoff.telescope')
  lua require('anordhoff.treesitter')
endif
