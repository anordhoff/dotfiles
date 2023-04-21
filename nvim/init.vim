" --------------------------------------
" settings
" --------------------------------------

" TODO: yo(something) which enables/disables tab lines, example:
" test:
" | test2:
" | | test3: test4
" | | test4: test3

" load internal packages
if &loadplugins
  packadd cfilter
endif

" basic settings
set number             " enable line numbers
set noincsearch        " do not immediately jump to first search hit
set noshowmode         " hide the mode from the bottom row
set ignorecase         " case-insensitive searching...
set smartcase          " ...but not if the search contains a capital letter
set splitright         " split vertical windows to the right of current window
set splitbelow         " split horizontal windows below current window
set foldmethod=syntax  " fold based on syntax highlighting items
set foldnestmax=1      " limit to 1 nested fold
set foldlevel=1        " don't automatically close folds
set fillchars=vert:\|  " use the pipe symbol as a vertical separator
set textwidth=79       " wrap lines at 79 characters when formatting
set scrolloff=2        " keep a minimum of 2 lines above and below the cursor
set sidescrolloff=8    " keep a minimum of 8 columns before & after the cursora
set mouse=             " disable mouse support
set ttimeoutlen=1      " minimal delay for escape key presses
set shell=/bin/zsh\ -i " interactive command mode shell (for aliases)

" use spaces by default (NOTE: vim-sleuth sets softtabstop=-1)
set tabstop=2
set softtabstop=0
set shiftwidth=2
set expandtab
set smarttab

" make line wrapping look nicer, but don't wrap by default
set nowrap
set linebreak
set breakindent
set showbreak=\ ..\  " trailing whitespace

" show possible completions in a pmenu; insert longest common text of matches
set completeopt=menu,longest
set pumheight=10

" use a wildmenu for command line completion
" TODO: :hi Statusline ctermbg=0, which makes commandline completion look bad
set wildoptions=tagfile
set wildmode=longest:full,full
set wildignorecase

" list of file patterns to ignore
set wildignore+=tags,.git/**,vendor/**,node_modules/**,package/opt/**,package/start/**

" show tabs and trailing whitespace
" TODO: should I use listchars for all files, or only specific? Show tabs or
" just spaces?
set list
" set listchars=tab:<->,trail:-
set listchars=tab:\ \ ,trail:-

" don't show trailing spaces while in insert mode
augroup listchars
  autocmd!
  autocmd InsertEnter * setlocal listchars-=trail:-
  autocmd InsertLeave * setlocal listchars+=trail:-
augroup END

" disable automatic line wrapping for non-comment text; disable insertion of
" the current comment leader when creating a new line
augroup formatoptions
  autocmd!
  " autocmd BufNewFile,BufRead,FileType,OptionSet * set fo-=t fo-=r fo-=o
  autocmd BufNewFile,BufRead,FileType,OptionSet * setlocal fo-=t fo-=r fo-=o
augroup END

" enable spellchecking for text files, markdown, and git commit messages
augroup spellcheck
  autocmd!
  autocmd FileType text,markdown,gitcommit setlocal spell
augroup END

" restore cursor to previous location when opening a file
augroup cursor
  autocmd!
  autocmd BufRead * autocmd FileType <buffer> ++once
    \ if &ft !~# 'commit\|rebase' && line("'\"") > 1 &&
    \ line("'\"") <= line("$") | exec 'normal! g`"zz' | endif
augroup END

" disable optional providers
let g:loaded_python3_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_node_provider = 0

" load custom colorscheme
colorscheme colorscheme

" source work init.vim
runtime job.vim


" --------------------------------------
" keymaps
" --------------------------------------

" leader key
let mapleader = "\<space>"

" prevent clipboard hijacking
inoremap <c-r>+ <c-r><c-r>+
inoremap <c-r>* <c-r><c-r>*

" make [[, ][, ]], and [] less useless for most languages (see :h section)
map <silent> [[ ?{<cr><c-l>w99[{0
map <silent> ][ /}<cr><c-l>b99]}0
map <silent> ]] j0?{<cr><c-l>w99[{%/{<cr><c-l>0
map <silent> [] k$/}<cr><c-l>b99]}%?}<cr><c-l>0

" quickly run a command in a new terminal buffer
nnoremap z<space> :term<space>

" grep current file or directory
nnoremap g<space> :lvimgrep  %<left><left>
nnoremap <leader>g :vimgrep  **/*<left><left><left><left><left>

" edit
nnoremap <leader>e :e **/*
nnoremap <leader>b :ls<cr>:b<space>

" toggle the quickfix list window
nnoremap <silent> <leader>q :call QuickfixList()<cr>
function QuickfixList()
  if getqflist({'winid': 0}).winid
    cclose
  else
    copen
    exec 'normal! <c-w><c-w>'
  endif
endfunction

" toggle the location list window
nnoremap <silent> <leader>l :call LocationList()<cr>
function LocationList()
  try
    if getloclist(0, {'winid': 0}).winid
      lclose
    else
      lopen
      exec 'normal! <c-w><c-w>'
    endif
  catch 'E776'
    echohl ErrorMsg | echo 'E776: No location list' | echohl None
  endtry
endfunction

" maximize (toggle) the current window (NOTE: overrides default :pc mapping)
nnoremap <silent> <c-w>z <c-w>\|<c-w>_
nnoremap <silent> <c-w><c-z> <c-w>\|<c-w>_

" trigger omni completion
inoremap <expr> <tab> pumvisible() ? '<c-n>' :
  \ getline('.')[col('.') - 2] !~ '^\s\?$' ? '<c-x><c-o>' : '<tab>'
inoremap <expr> <s-tab> pumvisible() ? '<c-p>' :
  \ getline('.')[col('.') - 2] !~ '^\s\?$' ? '<c-x><c-o>' : '<s-tab>'

" get highlight group under the cursor
command Hi call s:syngroup()
function s:syngroup()
  for l:i1 in synstack(line('.'), col('.'))
    let l:i2 = synIDtrans(l:i1)
    echo synIDattr(l:i1, 'name') '->' synIDattr(l:i2, 'name')
  endfor
endfunction

" clear the specified register (:wshada! to persist changes)
command! -nargs=1 Clear call s:clear_register(<q-args>)
function s:clear_register(chars)
  for l:char in split(a:chars, '\zs')
    call setreg(l:char, [])
  endfor
  echo "Successfully cleared registers '" . a:chars .
    \ "'. Execute :wshada! to persist changes"
endfunction

" only the active window has cursorline
augroup cursorline
  autocmd!
  autocmd BufEnter,WinEnter * setlocal cursorline
  autocmd BufLeave,WinLeave * setlocal nocursorline
augroup END

" --------------------------------------
" statusline
" --------------------------------------

" copy StatusLine and StatusLineNC highlight groups
exec 'highlight StatusLineActive' .
  \ ' ctermfg=' . nvim_get_hl(0, {"name": "StatusLine"})["ctermfg"] .
  \ ' ctermbg=' . nvim_get_hl(0, {"name": "StatusLine"})["ctermbg"]
exec 'highlight StatusLineInactive' .
  \ ' ctermfg=' . nvim_get_hl(0, {"name": "StatusLineNC"})["ctermfg"] .
  \ ' ctermbg=' . nvim_get_hl(0, {"name": "StatusLineNC"})["ctermbg"]

" set StatusLine and StatusLineNC backgrounds to the terminal background
highlight StatusLine ctermbg=none
highlight StatusLineNC ctermbg=none

" custom status line
set statusline=%!Statusline(g:statusline_winid)
function Statusline(winid)
  let l:statusline  = ' ' . Background(a:winid) " left padding; set status line background color
  let l:statusline .= ' [%n]'                   " buffer number
  let l:statusline .= '  %f  '                  " filepath
  let l:statusline .= '%{NopluginFlag()}'       " plugin flag
  let l:statusline .= '%{PasteFlag()}'          " paste flag
  let l:statusline .= '%H%W%R%M'                " help/preview/read-only/modified flags
  let l:statusline .= '%=   %c%V  :  %2l/%L'    " byte index, virtual column number; line number
  let l:statusline .= '%{Filetype()}'           " filetype
  let l:statusline .= '%* '                     " reset background color; right padding
  return l:statusline
endfunction

" quickfix list / location list / netrw / terminal buffer status lines
augroup statusline
  autocmd!
  autocmd Filetype qf setlocal statusline=%!QuickfixListStatusline(g:statusline_winid)
  autocmd Filetype netrw setlocal statusline=%!NetrwStatusline(g:statusline_winid)
  autocmd TermOpen * setlocal statusline=%!TermStatusline(g:statusline_winid)
augroup END
function QuickfixListStatusline(winid)
  return ' ' . Background(a:winid) . ' [%n]  %l/%L lines%=%q %* '
endfunction
function NetrwStatusline(winid)
  return ' ' . Background(a:winid) . ' [%n]  %l/%L lines%=[netrw] %* '
endfunction
function TermStatusline(winid)
  return ' ' . Background(a:winid) . ' [%n]  %{TermShell()}%{TermMode()}  %{NopluginFlag()}%{PasteFlag()}%R%=[term] %* '
endfunction

" set background depending on whether the window is active
function Background(winid)
  return a:winid == win_getid() ? '%#StatusLineActive#' : '%#StatusLineInactive#'
endfunction

" correct padding when there is no filetype
function Filetype()
  return &filetype == '' ? ' ' : '  [' . &filetype . '] '
endfunction

" noplugin flag if running with --noplugin set
function NopluginFlag()
  return !&loadplugins ? 'NP' : ''
endfunction

" set paste flag if paste has been set
function PasteFlag()
  if !&paste
    return ''
  elseif &loadplugins
    return 'P'
  else
    return ',P'
  endif
endfunction

" return shell used by terminal
function TermShell()
  return split(b:term_title, ':')[-1]
endfunction

" set 'insert' flag if terminal buffer is in 'terminal' mode
function TermMode()
  return mode() == 't' ? '  (insert)' : ''
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
  nnoremap <silent> <leader>t :Lexplore<cr>
endif


" --------------------------------------
" notes
" --------------------------------------

" notes directory
let g:notesdir = '~/notes/misc.md'

" toggle the notebook
nnoremap <silent> <leader>n :call ToggleNotes(g:notesdir)<cr>
function ToggleNotes(dir)
  if !exists('t:notesbuf')
    let t:notesbuf = 0
  endif
  if !exists('t:noteswin')
    let t:noteswin = 0
  endif

  " toggle the notes window, saving the currently open buffer
  if win_gotoid(t:noteswin)
    let t:notesbuf = bufnr('%')
    hide
  else
    try
      exec 'sbuffer ' . t:notesbuf
    catch
      exec 'split ' . a:dir
      let t:notesbuf = bufnr('%')
    endtry
    let t:noteswin = win_getid()
  endif
endfunction

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
tnoremap <c-[> <c-\><c-n>
tnoremap <esc> <c-\><c-n>

" open terminal in a horizontal or vertical split
nnoremap <silent> <a-s> :call ToggleTerm(0)<cr>
nnoremap <silent> <a-v> :call ToggleTerm(1)<cr>

" toggle terminal without leaving terminal insert mode
tnoremap <silent> <a-s> <c-\><c-n>:call ToggleTerm(0)<cr>
tnoremap <silent> <a-v> <c-\><c-n>:call ToggleTerm(1)<cr>

" use ctrl-r to access registers in terminal insert mode
tnoremap <expr> <c-r> '<c-\><c-n>"' . nr2char(getchar()) . 'pi'

" toggle a horizontal/vertical terminal split
function ToggleTerm(vsplit)
  if !exists('t:termbuf')
    let t:termbuf = 0
  endif
  if !exists('t:termwin')
    let t:termwin = 0
  endif

  " if a terminal window is open, hide it; else, (re)open a terminal window
  if bufname(winbufnr(t:termwin)) =~ '^term://' && win_gotoid(t:termwin)
    hide
  else
    try
      if a:vsplit
        exec 'vertical sbuffer ' . t:termbuf
      else
        exec 'sbuffer ' . t:termbuf
      endif
      startinsert!
    catch
      if a:vsplit
        exec 'vsplit +term'
      else
        exec 'split +term'
      endif
      let t:termbuf = bufnr('%')
    endtry
    let t:termwin = win_getid()
  endif
endfunction

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
" neovim plugins
" --------------------------------------

if &loadplugins
lua << EOT
require('impatient')
require('config.leap')
require('config.lspconfig')
require('config.telescope')
require('config.treesitter')
EOT
endif
