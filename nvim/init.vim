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
set fillchars=vert:\|  " use the pipe symbol as a vertical separator
set textwidth=79       " wrap lines at 79 characters when formatting
set scrolloff=2        " keep a minimum of 2 lines above and below the cursor
set sidescrolloff=8    " keep a minimum of 8 columns before & after the cursor
set shell=/bin/zsh\ -i " interactive command mode shell (for aliases)

" use tabs by default
set tabstop=4
set shiftwidth=4
set noexpandtab

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

" folds are managed manually unless foldmethod is set in after/ftplugin/
" TODO: FoldText is broken if folded text is indented
set foldnestmax=1
set foldlevel=1
set fillchars=fold:\  " trailing whitespace
set foldtext=FoldText()
function FoldText()
  let l:line = getline(v:foldstart)
  let l:numlines = v:foldend - v:foldstart
  let l:fillcount = winwidth('%') - len(line) - len(numlines) - 9
  if l:fillcount > 0
    return l:line . ' ' . repeat('.', l:fillcount) . ' (' . l:numlines . ')'
  else
    return l:line . ' ' . repeat('.', l:fillcount + 5)
  endif
endfunction

" load custom colorscheme
colorscheme colorscheme

" disable automatic line wrapping for non-comment text; disable insertion of
" the current comment leader when creating a new line
augroup formatoptions
  autocmd!
  autocmd BufNewFile,BufRead,FileType,OptionSet * set fo-=t fo-=r fo-=o
  autocmd BufNewFile,BufRead,FileType,OptionSet * setlocal fo-=t fo-=r fo-=o
augroup END

" TODO: git mergetool starts in merged file

" enable the cursorline when in diff mode
" TODO: randomly stopped working?
" if &diff | set cursorline | endif
" augroup diff
"   autocmd!
"   autocmd BufNewFile,BufRead * if &diff | let &cursorline=1 | endif
"   autocmd OptionSet diff let &cursorline=v:option_new
"   autocmd BufHidden * set nocursorline
" augroup END

" enable spellchecking for text files, markdown, and git commit messages
augroup spellcheck
  autocmd!
  autocmd FileType text,markdown,gitcommit setlocal spell
augroup END

" TODO: remove once neovim v0.8 is live
let g:do_filetype_lua = 1
let g:did_load_filetypes = 0


" TODO: vim dispatch (i.e. m<space> to run make "something" has zle errors)

" --------------------------------------
" keymaps
" --------------------------------------

" leader key
let mapleader = "\<Space>"

" prevent clipboard hijacking
inoremap <C-r>+ <C-r><C-r>+
inoremap <C-r>* <C-r><C-r>*

" quickly run a command
nnoremap <leader><space> :!
nnoremap <leader>t :terminal<space>

" vimgrep
nnoremap <leader>gq :vimgrep<space>
nnoremap <leader>gl :lvimgrep  %<left><left>

" toggle the quickfix list window
nnoremap <silent> <leader>q :call init#togglequickfixlist()<CR>

" toggle the location list window
nnoremap <silent> <leader>l :call init#togglelocationlist()<CR>

" maximize (toggle) the current window (NOTE: overrides :pclose mapping)
nnoremap <silent> <C-w>z :call init#togglemaximizewindow()<CR>
nnoremap <silent> <C-w><C-z> :call init#togglemaximizewindow()<CR>

" toggle sharing mode (turns on cursorline/cursorcolumn for active buffer)
let g:sharing = 0
command Share :call init#togglesharing()
augroup sharing
  autocmd!
  autocmd WinEnter * if g:sharing | execute 'set cursorline cursorcolumn' | endif
  autocmd WinLeave * if g:sharing | execute 'set nocursorline nocursorcolumn' | endif
augroup END

" get highlight group under the cursor
command Hi :call init#syngroup()

" clear the specified register (:wshada! to persist changes)
nnoremap <leader>cr :call setreg('', [])<Left><Left><Left><Left><Left><Left>

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
  autocmd Filetype qf setlocal statusline=\ \[%n\]\ \ %l/%L\ lines%=%q\ 
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
  if l:filetype == 'dirvish'
    return 'dirvish'
  elseif l:bufname == ''
    return '[No Name]'
  elseif l:bufname =~ '/nvim/runtime/doc/'
    return 'help'
  elseif l:bufname =~ '^term://'
    return 'terminal'
  else
    return l:bufname
  endif
endfunction


" --------------------------------------
" notes
" --------------------------------------

let g:notesdir = '~/notes'

" toggle the notebook
nnoremap <silent> <leader>n :call note#togglenotes(g:notesdir)<CR>

" prevent notes from being added to the buffer list
augroup notes
  autocmd!
  autocmd BufNewFile,BufRead ~/notes/*.txt,~/notes/*.md setlocal nobuflisted
augroup END


" --------------------------------------
" terminal
" --------------------------------------

" TODO: 1. return to same :term when closing nested nvim session (ie <C-x><C-e>)
"       2. git mergetool with --remote
"       3. implement i_CTRL-O command for terminal insert mode

" set the preferred editor to use the current session's RPC server
let $VISUAL="nvim --server " . v:servername . " --remote"
let $EDITOR="nvim --server " . v:servername . " --remote"

" exit to normal mode using ctrl-[ / esc
tnoremap <C-[> <C-\><C-n>
tnoremap <esc> <C-\><C-n>

" open terminal in a horizontal or vertical split
nnoremap <silent> <A-s> :call term#toggleterm(0)<CR>
nnoremap <silent> <A-v> :call term#toggleterm(1)<CR>

" toggle terminal without leaving terminal insert mode
tnoremap <silent> <A-s> <C-\><C-n>:call term#toggleterm(0)<CR>
tnoremap <silent> <A-v> <C-\><C-n>:call term#toggleterm(1)<CR>

" use <A-r> to access registers in terminal insert mode
tnoremap <expr> <A-r> '<C-\><C-N>"'.nr2char(getchar()).'pi'

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
  " native vim plugins
  packadd cfilter

  " neovim plugins
  lua require('impatient')
  lua require('anordhoff.leap')
  lua require('anordhoff.lspconfig')
  lua require('anordhoff.telescope')
  lua require('anordhoff.treesitter')
endif
