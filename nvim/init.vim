" --------------------------------------
" settings
" --------------------------------------

" TODO: automatically add the next ordered list value (1. 2. 3.) when hitting enter
" TODO: telescope preview window does not respect modeline (example: zprofile)
" TODO: format TabLabel as #windows:buffer-name<dirty>, eg 2:init.vim+
" TODO: using nnoremap in after/ftplugin/netrw.vim doesn't work, but nmap breaks ctrl_t to open a new tab
" TODO: when toggling notes, use the name of the directory with `.git/`, rather than just the root of the dir
" TODO: should function use lowercase or uppercase names? qf uses CamelCase

set notermguicolors   " disable 24-bit colors
set number            " enable line numbers
set relativenumber    " use relative line numbers for all but the current line
set noshowmode        " hide the mode from the bottom row
set noincsearch       " do not immediately jump to first search hit
set ignorecase        " case-insensitive searching...
set smartcase         " ...but not if the search contains a capital letter
set splitright        " split vertical windows to the right of current window
set splitbelow        " split horizontal windows below current window
set splitkeep=screen  " keep text on the same line when splitting windows
set textwidth=80      " wrap lines at 80 characters
set scrolloff=2       " keep a minimum of 2 lines above and below the cursor
set sidescrolloff=8   " keep a minimum of 8 columns before & after the cursor
set smoothscroll      " scrolling works with screen lines
set foldmethod=syntax " fold based on syntax highlighting items
set foldnestmax=1     " limit to 1 nested fold
set foldlevel=1       " don't automatically close folds
set mmp=10000         " prevent memory errors when loading large buffers
set ttimeoutlen=1     " minimal delay for escape key presses
set shellcmdflag=-ic  " interactive command mode shell (for aliases)

" use two spaces instead of tabs by default
set tabstop=2
set shiftwidth=2
set expandtab

" show possible completions in a pmenu; insert longest common text of matches
set completeopt=menu,longest,preview
set pumheight=10

" use a wildmenu for command line completion
set wildoptions=pum,tagfile
set wildmode=longest:full,full
set wildignorecase

" list of file patterns to ignore
set wildignore+=tags,*.tags,.git/**,bin/**,vendor/**,node_modules/**,package/opt/**,package/start/**,tmux/plugins/**

" make line wrapping look nicer, but don't wrap by default
set nowrap
set linebreak
set breakindent
let &showbreak=' .. '

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

" don't auto-wrap text; format comments with gq;
" prevent filetypes from overwriting formatoptions
augroup formatoptions
  autocmd!
  autocmd Filetype * if &ft != "markdown" | setlocal formatoptions=qjw | endif
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

" disable optional providers
let g:loaded_python3_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_node_provider = 0

" load custom colorscheme
colorscheme colorscheme


" --------------------------------------
" keymaps
" --------------------------------------

" leader key
let mapleader = "\<space>"

" prevent clipboard hijacking
inoremap <c-r>+ <c-r><c-r>+
inoremap <c-r>* <c-r><c-r>*

" ctrl-p and ctrl-n match the current command-line
cnoremap <c-p> <up>
cnoremap <c-n> <down>

" <left> and <right> move the cursor instead of selecting wildmenu matches
cnoremap <left> <space><bs><left>
cnoremap <right> <space><bs><right>

" file and buffer navigation
nnoremap <leader>e :e **/*
nnoremap <leader>s :sp **/*
nnoremap <leader>v :vs **/*
nnoremap <leader>b :b **/*

" grep current buffer or current directory (project)
nnoremap gb :lvimgrep  %<left><left>
nnoremap gp :vimgrep  **/*<left><left><left><left><left>

" find and replace the word under the cursor
nnoremap <leader>% :%s/\<<c-r>=expand("<cword>")<cr>\>/

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
command Hi call init#syngroup()

" clear the specified register
command -nargs=1 Clear call init#clear_register(<q-args>)

" source init.vim and reload the current file
command So :source ~/.config/nvim/init.vim | :edit


" --------------------------------------
" comment and duplicate lines of code
" --------------------------------------

" comment a range of lines
command -range Comment call comment#comment_range(<line1>, <line2>)

" duplicate a count of lines
nnoremap <silent> gzz :<c-u>call comment#duplicate_lines(v:count1)<cr>

" duplicate the highlighted lines
vnoremap <silent> gz :<c-u>call comment#duplicate_visual("'<", "'>")<cr>

" duplicate lines that a motion moves over
nnoremap <silent> gz :set opfunc=comment#duplicate_operator<cr>g@

" duplicate a range of lines
command -range Duplicate call comment#duplicate_range(<line1>, <line2>)


" --------------------------------------
" statusline
" --------------------------------------

" custom statusline (requires additional StatusLineActive and StatusLineInactive highlight groups)
set statusline=%!Statusline(g:statusline_winid)

" assemble the custom statusline for most filetypes
function Statusline(winid)
  let statusline  = ' ' .. Background(a:winid) " left padding; set status line background color
  let statusline .= ' [%n]  '                  " buffer number
  let statusline .= '%f'                       " filepath
  let statusline .= '%{GitBranch()}  '         " git branch
  let statusline .= '%{NopluginFlag()}'        " plugin flag
  let statusline .= '%H%W%R%M'                 " help/preview/read-only/modified flags
  let statusline .= '%=   %c%V  :  %2l/%L'     " byte index, virtual column number; line number
  let statusline .= '%{Filetype()}'            " filetype
  let statusline .= '%* '                      " reset background color; right padding
  return statusline
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
  let branch = substitute(substitute(FugitiveStatusline(), '^[Git(', '', ''), ')]$', '', '')
  if strlen(branch .. expand('%')) > 56
    return '  (' .. strpart(branch, 0, 53 - strlen(expand('%'))) .. '...)'
  else
    return '  (' .. branch .. ')'
  endif
endfunction

" noplugin flag if running with --noplugin set
function NopluginFlag()
  return !&loadplugins ? 'NP' : ''
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
  return mode() == 't' ? '  (insert)' : ''
  " return mode() == 't' ? '   (insert)' : ''
endfunction


" --------------------------------------
" tabline
" --------------------------------------

set tabline=%!TabLine()

function TabLine()
  let line = '%#StatusLine#' .. ' ' .. '%#TabLine#'
  for tab in range(tabpagenr('$'))
    if tab + 1 == tabpagenr()
      let line ..= '%#TabLineSel#'
    else
      let line ..= '%#TabLine#'
    endif
    let line ..= ' %{TabLabel(' .. (tab + 1) .. ')} '
  endfor
  let line ..= '%#TabLineFill#%T' .. '%=%#StatusLine#' .. ' '
  return line
endfunction

function TabLabel(n)
  let winnr = tabpagewinnr(a:n)
  let buflist = tabpagebuflist(a:n)
  let bufname = bufname(buflist[winnr - 1])
  let filetype = getbufvar(buflist[winnr - 1], '&filetype')
  if bufname == ''
    return '[No Name]'
  elseif bufname =~ '/nvim/runtime/doc/'
    return 'help'
  elseif filetype == 'netrw'
    return 'netrw'
  elseif filetype == 'dirvish'
    return 'dirvish'
  elseif bufname =~ '^term://'
    return 'terminal'
  else
    return bufname
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
  nnoremap <silent> <leader>t <cmd>Lexplore<cr>
endif


" --------------------------------------
" notes
" --------------------------------------

" notes directory
let g:notes = '~/notes/projects/'

" toggle the notebook
nnoremap <silent> <leader>n <cmd>call notes#toggle(g:notes)<cr>

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
nnoremap <silent> <a-s> <cmd>call term#Toggle(0)<cr>
nnoremap <silent> <a-v> <cmd>call term#Toggle(1)<cr>
nnoremap <silent> <a-w> <cmd>call term#Focus()<cr>

" toggle terminal without leaving terminal insert mode
tnoremap <silent> <a-s> <c-\><c-n><cmd>call term#Toggle(0)<cr>
tnoremap <silent> <a-v> <c-\><c-n><cmd>call term#Toggle(1)<cr>
tnoremap <silent> <a-w> <c-\><c-n><cmd>call term#Focus()<cr>

" use ctrl-r to access registers in terminal insert mode
tnoremap <expr> <c-r> '<c-\><c-n>"' .. nr2char(getchar()) .. 'pi'

" use ctrl-r ctrl-r to reverse-history search
tnoremap <c-r><c-r> <c-r>

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

" source lua config
lua require('config.init')


" --------------------------------------
" work
" --------------------------------------

" source work init.vim
runtime job.vim
