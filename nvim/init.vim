" --------------------------------------
" settings
" --------------------------------------

" TODO: gr<space> keybinding for quick grep conflicts with lspconfig's gr
" TODO: keep conceal enabled when using leap within dirvish

" basic settings
set notermguicolors    " disable 24-bit colors
set cb=unnamedplus     " default to the clipboard register
set number             " enable line numbers
set noshowmode         " hide the mode from the bottom row
set noincsearch        " do not immediately jump to first search hit
set ignorecase         " case-insensitive searching...
set smartcase          " ...but not if the search contains a capital letter
set splitright         " split vertical windows to the right of current window
set splitbelow         " split horizontal windows below current window
set splitkeep=screen   " keep text on the same line when splitting windows
set textwidth=80       " wrap lines at 80 characters
set formatoptions=cqjw " don't auto-wrap text; format comments with gq
set scrolloff=2        " keep a minimum of 2 lines above and below the cursor
set sidescrolloff=8    " keep a minimum of 8 columns before & after the cursor
set smoothscroll       " scrolling works with screen lines
set foldmethod=syntax  " fold based on syntax highlighting items
set foldnestmax=1      " limit to 1 nested fold
set foldlevel=1        " don't automatically close folds
set mmp=10000          " prevent memory errors when loading large buffers
set ttimeoutlen=1      " minimal delay for escape key presses
set shellcmdflag=-ic   " interactive command mode shell (for aliases)

" scrolling with the mouse or trackpad moves the screen instead of the cursor
set mouse=nvi
set mousescroll=ver:1,hor:0

" prevent basic mouse clicks from doing anything but scrolling
map <leftmouse>     <nop>
map <middlemouse>   <nop>
map <rightmouse>    <nop>
map <2-leftmouse>   <nop>
map <2-middlemouse> <nop>
map <2-rightmouse>  <nop>
map <3-leftmouse>   <nop>
map <3-middlemouse> <nop>
map <3-rightmouse>  <nop>
map <4-leftmouse>   <nop>
map <4-middlemouse> <nop>
map <4-rightmouse>  <nop>

" use two spaces instead of tabs by default
set tabstop=2
set shiftwidth=2
set expandtab

" make line wrapping look nicer, but don't wrap by default
set nowrap
set linebreak
set breakindent
let &showbreak=' .. '

" show possible completions in a pmenu; insert longest common text of matches
set completeopt=menu,longest,preview
set pumheight=10

" wrap text in the preview window
augroup preview
  autocmd!
  autocmd WinEnter * if &previewwindow | setlocal wrap | endif
augroup END

" close the preview window when done completing
augroup completion
  autocmd!
  autocmd CompleteDone * pclose
augroup END

" use a wildmenu for command line completion
set wildoptions=pum,tagfile
set wildmode=longest:full,full
set wildignorecase

" list of file patterns to ignore
set wildignore+=tags,*.tags,.git/**,bin/**,vendor/**,node_modules/**,package/opt/**,package/start/**,tmux/plugins/**

" prevent filetypes from overwriting formatoptions
augroup formatoptions
  autocmd!
  autocmd FileType * setlocal formatoptions=cqjw
augroup END

" enable the cursorline on the active window
augroup cursorline
  autocmd!
  autocmd BufEnter,WinEnter * setlocal cursorline
  autocmd BufLeave,WinLeave * setlocal nocursorline
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

" prevent delete commands from overwriting the clipboard register
noremap <expr> d v:register =~ '[\*+]' ? '""d' : 'd'
noremap <expr> x v:register =~ '[\*+]' ? '""x' : 'x'
noremap <expr> c v:register =~ '[\*+]' ? '""c' : 'c'
noremap <expr> s v:register =~ '[\*+]' ? '""s' : 's'
noremap <expr> D v:register =~ '[\*+]' ? '""D' : 'D'
noremap <expr> X v:register =~ '[\*+]' ? '""X' : 'X'
noremap <expr> C v:register =~ '[\*+]' ? '""C' : 'C'
noremap <expr> S v:register =~ '[\*+]' ? '""S' : 'S'

" ctrl-p and ctrl-n match the current command-line
cnoremap <c-p> <up>
cnoremap <c-n> <down>

" <left> and <right> move the cursor instead of selecting wildmenu matches
cnoremap <left> <space><bs><left>
cnoremap <right> <space><bs><right>

" grep current file or directory
nnoremap gr<space> :lvimgrep  %<left><left>
nnoremap gp<space> :vimgrep  **/*<left><left><left><left><left>

" file and buffer navigation
nnoremap <leader>e :e **/*
nnoremap <leader>s :sp **/*
nnoremap <leader>v :vs **/*
nnoremap <leader>b :b **/*

" maximize the current window (overwrites default :pclose mapping)
nnoremap <silent> <c-w>z <c-w>\|<c-w>_
nnoremap <silent> <c-w><c-z> <c-w>\|<c-w>_

" trigger omni completion using <tab>
" TODO: use ctrl-i to insert tab character; not supported by tmux
"   (https://github.com/tmux/tmux/issues/2705, https://github.com/neovim/neovim/issues/17867)
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

" clear the specified register
command! -nargs=1 Clear call s:clear_register(<q-args>)
function s:clear_register(chars)
  for l:char in split(a:chars, '\zs')
    call setreg(l:char, [])
  endfor
  echo "Successfully cleared registers '" .. a:chars ..
    \ "'. Execute :wshada! to persist changes"
endfunction

" source init.vim and reload the current file
command So :source ~/.config/nvim/init.vim | :edit


" --------------------------------------
" comment and duplicate
" --------------------------------------

function! Comment(start, end)
  exec a:start .. ',' .. a:end .. 'normal gcc'
  exec 'normal! ' .. a:start .. 'G'
endfunction

" comment a range of lines
command -range Comment call CommentRange(<line1>, <line2>)
function! CommentRange(start, end)
  call Comment(a:start, a:end)
  exec 'normal! 0'
endfunction

function! Duplicate(start, end)
  exec a:start .. ',' .. a:end .. 'copy ' .. a:end
  exec a:start .. ',' .. a:end .. 'normal gcc'
  exec 'normal! ' .. a:end .. 'Gj'
endfunction

" duplicate a count of lines
nnoremap <silent> gzz :<c-u>call DuplicateLines(v:count1)<cr>
function! DuplicateLines(count)
  call Duplicate(line('.'), line('.') + a:count - 1)
  silent! call repeat#set("gzz", a:count)
endfunction

" duplicate the highlighted lines
xnoremap <silent> gz :<c-u>call DuplicateVisual("'<", "'>")<cr>
function! DuplicateVisual(start, end)
  let l:start = line(a:start)
  let l:end = line(a:end)
  call Duplicate(l:start, l:end)
  silent! call repeat#set("gzz", l:end - l:start + 1)
endfunction

" duplicate lines that a motion moves over
nnoremap <silent> gz :set opfunc=DuplicateOperator<cr>g@
function! DuplicateOperator(type)
  call Duplicate(line("'["), line("']"))
  exec 'normal! 0'
endfunction

" duplicate a range of lines
command -range Duplicate call DuplicateRange(<line1>, <line2>)
function! DuplicateRange(start, end)
  call Duplicate(a:start, a:end)
  exec 'normal! 0'
endfunction


" --------------------------------------
" statusline
" --------------------------------------

" custom status line (requires additional StatusLineActive and
" StatusLineInactive highlight groups)
set statusline=%!Statusline(g:statusline_winid)
function Statusline(winid)
  let l:statusline  = ' ' .. Background(a:winid) " left padding; set status line background color
  let l:statusline .= ' [%n]  '                  " buffer number
  let l:statusline .= '%f'                       " filepath
  let l:statusline .= '%{GitBranch()}  '         " git branch
  let l:statusline .= '%{NopluginFlag()}'        " plugin flag
  let l:statusline .= '%H%W%R%M'                 " help/preview/read-only/modified flags
  let l:statusline .= '%=   %c%V  :  %2l/%L'     " byte index, virtual column number; line number
  let l:statusline .= '%{Filetype()}'            " filetype
  let l:statusline .= '%* '                      " reset background color; right padding
  return l:statusline
endfunction

" quickfix and location list / netrw / terminal buffer status lines
augroup statusline
  autocmd!
  autocmd Filetype qf setlocal statusline=%!QuickfixListStatusline(g:statusline_winid)
  autocmd Filetype netrw setlocal statusline=%!NetrwStatusline(g:statusline_winid)
  autocmd TermOpen * setlocal statusline=%!TermStatusline(g:statusline_winid)
augroup END
function QuickfixListStatusline(winid)
  return ' ' .. Background(a:winid) .. " [%l/%L lines]  %{QuickfixTitle()}%=%q %* "
endfunction
function NetrwStatusline(winid)
  return ' ' .. Background(a:winid) .. ' [%n]  %l/%L lines%=[netrw] %* '
endfunction
function TermStatusline(winid)
  return ' ' .. Background(a:winid) .. ' [%n]  %{TermShell()}%{TermMode()}  %{NopluginFlag()}%R%=[term] %* '
endfunction

" set background depending on whether the window is active
function Background(winid)
  return a:winid == win_getid() ? '%#StatusLineActive#' : '%#StatusLineInactive#'
endfunction

" correct padding when there is no filetype
function Filetype()
  return &filetype == '' ? ' ' : '  [' .. &filetype .. '] '
endfunction

" show the git branch if plugins are enabled
function GitBranch()
  if !&loadplugins || empty(FugitiveGitDir(bufnr('')))
    return ''
  endif
  let l:branch = substitute(substitute(FugitiveStatusline(), '^[Git(', '', ''), ')]$', '', '')
  if strlen(l:branch .. expand('%')) > 56
    return '  (' .. strpart(l:branch, 0, 53 - strlen(expand('%'))) .. '...)'
  else
    return '  (' .. l:branch .. ')'
  endif
endfunction

" noplugin flag if running with --noplugin set
function NopluginFlag()
  return !&loadplugins ? 'NP' : ''
endfunction

" return the title of the quickfix window
function QuickfixTitle()
  return exists('w:quickfix_title') ? w:quickfix_title .. '  ' : ''
endfunction

" return shell used by terminal
function TermShell()
  return split(b:term_title, ':')[-1]
endfunction

" set 'insert' flag if terminal buffer is in 'terminal' mode
function TermMode()
  " TODO: why is one of the spaces being dropped
  " return mode() == 't' ? '  (insert)' : ''
  return mode() == 't' ? '   (insert)' : ''
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
    let l:line .= ' %{TabLabel(' .. (l:tab + 1) .. ')} '
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
      exec 'botright sbuffer ' .. t:notesbuf
    catch
      exec 'botright split ' .. a:dir
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
let $VISUAL="nvim --server " .. v:servername .. " --remote"
let $EDITOR="nvim --server " .. v:servername .. " --remote"

" exit to normal mode using ctrl-[ or escape
tnoremap <c-[> <c-\><c-n>
tnoremap <esc> <c-\><c-n>

" open terminal in a horizontal or vertical split
nnoremap <silent> <a-s> :call ToggleTerm(0)<cr>
nnoremap <silent> <a-v> :call ToggleTerm(1)<cr>
nnoremap <silent> <a-w> :call FocusTerm()<cr>

" toggle terminal without leaving terminal insert mode
tnoremap <silent> <a-s> <c-\><c-n>:call ToggleTerm(0)<cr>
tnoremap <silent> <a-v> <c-\><c-n>:call ToggleTerm(1)<cr>
tnoremap <silent> <a-w> <c-\><c-n>:call FocusTerm()<cr>

" use ctrl-r to access registers in terminal insert mode
tnoremap <expr> <c-r> '<c-\><c-n>"' .. nr2char(getchar()) .. 'pi'

" use ctrl-r ctrl-r to reverse-history search
tnoremap <c-r><c-r> <c-r>

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
    wincmd p
  else
    try
      if a:vsplit
        exec 'botright vertical sbuffer ' .. t:termbuf
      else
        exec 'botright sbuffer ' .. t:termbuf
      endif
      startinsert!
    catch
      if a:vsplit
        exec 'botright vsplit +term'
      else
        exec 'botright split +term'
      endif
      startinsert!
      let t:termbuf = bufnr('%')
    endtry
    let t:termwin = win_getid()
  endif
endfunction

" switch between open terminal window and previous window
function FocusTerm()
  if !exists('t:termbuf') || !exists('t:termwin') || bufwinid(t:termbuf) == -1
      echohl ErrorMsg | echo 'No terminal window' | echohl None
      return
  endif
  if win_getid() == t:termwin
    wincmd p
  else
    call win_gotoid(t:termwin)
    startinsert!
  endif
endfunction

augroup terminal
  autocmd!

  " disable line numbers
  autocmd TermOpen * setlocal nonumber norelativenumber
  " hide the sign column
  autocmd TermOpen * setlocal signcolumn=no
  " prevent the terminal from being added to the buffer list
  autocmd TermOpen * setlocal nobuflisted
augroup END


" --------------------------------------
" neovim
" --------------------------------------

lua << EOT
vim.loader.enable()

if vim.api.nvim_get_option('loadplugins') then
  require('config.indent-blankline')
  require('config.leap')
  require('config.lint')
  require('config.lspconfig')
  require('config.rest')
  require('config.telescope')
  require('config.treesitter')
end
EOT
