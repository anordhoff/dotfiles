" --------------------------------------
" settings
" --------------------------------------

" TODO(bug): telescope preview window does not respect modeline (example: zprofile)
" TODO(bug): using nnoremap in after/ftplugin/netrw.vim doesn't work, but nmap breaks ctrl_t to open a new tab
" TODO(bug): copilot autosuggestions do not wrap correctly
" TODO(bug): use ctrl-i to insert tab character (not supported by tmux - https://github.com/tmux/tmux/issues/2705)

" TODO(feat): automatically add the next ordered list value (1. 2. 3.) when hitting enter
" TODO(feat): format TabLabel as #windows:buffer-name<dirty>, eg 2:init.vim+
" TODO(feat): when toggling notebook, use the name of the directory with `.git/`, rather than just the root of the dir
" TODO(feat): dispatch opening quickfix should not steal focus (can use :cc to move to highlighted error)
" TODO(feat): keymap/codeaction to implement an interface (creates a skeleton of all the required methods/fields of the interface)
" TODO(feat): <m-s>, <m-v>, <m-w> should toggle the term created by :Start (dispatch) if it exists
" TODO(feat): :Start, :Spawn should create a horizonal split that uses the full width of the screen
" TODO(feat): signature help shown with `K` keymap should handle backslashes (escape chars)
" TODO(feat): should I update dirvish so that it follows tpope file opening conventions (<CR>: edit, o: split, gO: vsplit, O: tab)
" TODO(feat): conceal can now conceal multiple lines (for example, long links in markdown, code blocks, etc)
" TODO(feat): look into built in snippets (default keymap is <tab>, which will conflict with completion)


set notermguicolors   " disable 24-bit colors
set number            " enable line numbers
" set relativenumber    " use relative line numbers for all but the current line
set noshowmode        " hide the mode from the bottom row
set noincsearch       " do not immediately jump to first search hit
set ignorecase        " case-insensitive searching...
set smartcase         " ...but not if the search contains a capital letter
set splitright        " split vertical windows to the right of current window
set splitbelow        " split horizontal windows below current window
set splitkeep=screen  " keep text on the same line when splitting windows
set textwidth=120     " wrap lines at 120 characters
set formatoptions=qjw " don't auto-wrap text; format comments with gq
set shortmess+=c      " don't give ins-completion-menu messages
set scrolloff=2       " keep a minimum of 2 lines above and below the cursor
set sidescrolloff=8   " keep a minimum of 8 columns before & after the cursor
set smoothscroll      " scrolling works with screen lines
set foldmethod=syntax " fold based on syntax highlighting items
set foldnestmax=1     " limit to 1 nested fold
set foldlevel=1       " don't automatically close folds
set mmp=10000         " prevent memory errors when loading large buffers
set timeoutlen=5000   " make complicated commands more forgiving to type
set ttimeoutlen=1     " minimal delay for escape key presses
set shellcmdflag=-ic  " interactive command mode shell (for aliases)
set diffopt+=vertical " start diff mode in vertical splits

" load internal packages
if &loadplugins
  packadd cfilter
endif

" use two spaces instead of tabs by default
set tabstop=2
set shiftwidth=2
set expandtab

" show possible completions in a pmenu
set completeopt=menuone,noselect,preview
set pumheight=10

" use a wildmenu for command line completion
set wildoptions=pum,tagfile
set wildmode=longest:full,full
set wildignorecase

" list of file patterns to ignore
set wildignore+=tags,*.tags,.git/**,**/bin/**,**/vendor/**,**/node_modules/**,**/package/opt/**,**/package/start/**,**/tmux/plugins/**

" ignore files and directories listed in .gitignore
let &wildignore .= gitignore#WildignoreList('.gitignore')

" make line wrapping look nicer, but don't wrap by default
set nowrap
set linebreak
set breakindent
let &showbreak=' .. '

" add jobfiles and jobfiles/after to vim's runtimepath
set runtimepath-=~/.config/nvim
let &runtimepath='~/.config/nvim,~/jobfiles/nvim,' . &runtimepath . ',~/jobfiles/nvim/after'

" wrap text in the preview window
augroup preview_config
  autocmd!
  autocmd WinEnter * if &previewwindow | setlocal wrap | endif
augroup END

" close the preview window when done completing
augroup completion_config
  autocmd!
  autocmd CompleteDone * pclose
augroup END

" prevent filetypes from overwriting formatoptions
augroup formatoptions_config
  autocmd!
  " autocmd Filetype * if &ft != "markdown" | setlocal formatoptions=qjw | endif
  autocmd Filetype * if &ft != "markdown" && &ft != "gitcommit" | setlocal formatoptions=qjw | endif
augroup END

" enable the cursorline on the active window
augroup cursorline_config
  autocmd!
  autocmd BufEnter,WinEnter * setlocal cursorline
  autocmd BufLeave,WinLeave * setlocal nocursorline
augroup END

" restore cursor to previous location when opening a file
augroup cursor_config
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
" keymaps and commands
" --------------------------------------

" leader key
let mapleader = "\<space>"

" prevent clipboard hijacking
inoremap <c-r>+ <c-r><c-r>+
inoremap <c-r>* <c-r><c-r>*

" ctrl-p and ctrl-n match the current command-line
cnoremap <c-p> <up>
cnoremap <c-n> <down>

" extend vim-husk such that ctrl-y and ctrl-w mimic bash
cnoremap <expr> <c-y> pumvisible() ? "\<c-y>" : "\<c-r>\""
cnoremap <c-w> <cmd>let g:iskeyword=&iskeyword<bar>
  \ set iskeyword=
  \ <cr><c-w><cmd>
  \ let &iskeyword=g:iskeyword<bar>
  \ unlet g:iskeyword<cr>

" file and buffer navigation
nnoremap <leader>e :e **/*
nnoremap <leader>s :sp **/*
nnoremap <leader>v :vs **/*
nnoremap <leader>b :b **/*

" jump to the definition in the tag file
nnoremap gd <c-]>

" grep current buffer or all files in current directory
nnoremap gb :lvimgrep  %<left><left>
nnoremap gp :vimgrep  **/*<left><left><left><left><left>

" maximize the current window
nnoremap <silent> <leader>z :tabnew %<cr>

" toggle the quickfix list window and maximize window to the width of vim
nnoremap <silent> <m-q> :call quickfix#ToggleQuickfixlist()<cr>

" toggle the location list window
nnoremap <silent> <m-l> :call quickfix#ToggleLocationlist()<cr>

" get change from local or remote buffer when using mergetool
nnoremap gh <cmd>set diffopt-=linematch:40<bar>diffget //2<bar>set diffopt+=linematch:40<bar>diffupdate<cr>
nnoremap gl <cmd>set diffopt-=linematch:40<bar>diffget //3<bar>set diffopt+=linematch:40<bar>diffupdate<cr>

" trigger tag/omni completion using <tab>
inoremap <expr> <tab> completion#TabComplete(0)
inoremap <expr> <s-tab> completion#TabComplete(1)

" reset completeopt option after manual completion
augroup completion_config
  autocmd!
  autocmd CompleteDone * :pclose
  autocmd CompleteDone * setlocal completeopt=menuone,noselect,preview
augroup END

" clear the specified register
command! -nargs=1 Clear call registers#Clear(<q-args>)

" source init.vim and reload the current file
command! Source :source ~/.config/nvim/init.vim | :edit


" --------------------------------------
" comment and duplicate lines of code
" --------------------------------------

" comment a range of lines
command! -range Comment call comment#CommentRange(<line1>, <line2>)

" duplicate a count of lines
nnoremap <silent> gzz :<c-u>call comment#DuplicateLines(v:count1)<cr>

" duplicate the highlighted lines
vnoremap <silent> gz :<c-u>call comment#DuplicateVisual("'<", "'>")<cr>

" duplicate lines that a motion moves over
nnoremap <silent> gz :set opfunc=comment#DuplicateOperator<cr>g@

" duplicate a range of lines
command! -range Duplicate call comment#DuplicateRange(<line1>, <line2>)


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
augroup statusline_config
  autocmd!

  autocmd Filetype qf setlocal statusline=%!QuickfixListStatusline(g:statusline_winid)
  autocmd Filetype netrw setlocal statusline=%!NetrwStatusline(g:statusline_winid)
  autocmd Filetype copilot-* setlocal statusline=%!CopilotStatusline(g:statusline_winid)
  autocmd TermOpen * setlocal statusline=%!TermStatusline(g:statusline_winid)
augroup END

function QuickfixListStatusline(winid)
  return ' ' .. Background(a:winid) .. " [%l/%L lines]  %{QuickfixTitle()}%=%q %* "
endfunction
function NetrwStatusline(winid)
  return ' ' .. Background(a:winid) .. ' [%n]  %l/%L lines%=[netrw] %* '
endfunction
function CopilotStatusline(winid)
  return ' ' .. Background(a:winid) .. ' [%n]  %{CopilotChatModel()}%=%{Filetype()}%* '
endfunction
function TermStatusline(winid)
  return ' ' .. Background(a:winid) .. ' [%n]  %{TermShell()}%{TermMode()}  %{NopluginFlag()}%R%=[term] %* '
endfunction

" return the title of the quickfix window
function QuickfixTitle()
  return exists('w:quickfix_title') ? w:quickfix_title .. '  ' : ''
endfunction

" return the model copilot-chat is using
function CopilotChatModel()
  return g:copilot_chat_model
endfunction

" return shell used by terminal
function TermShell()
  return split(b:term_title, ':')[-1]
endfunction

" set 'insert' flag if terminal buffer is in 'terminal' mode
function TermMode()
  " return mode() == 't' ? '  (insert)' : ''
  return mode() == 't' ? '   (insert)' : ''
endfunction


" --------------------------------------
" tabline
" --------------------------------------

" TODO(feat): use shortened dir names. For example,
"   main.go  ~/a/w/.g//6/main.go
" instead of
"   main.go  fugitive:///Users/.../.../webserver/.git//64bed7c379141ac196d8.../main.go

set tabline=%!TabLine()

function TabLine()
  let line = '%#StatusLine#' .. ' ' .. '%#TabLine#'
  for tab in range(tabpagenr('$'))
    if tab + 1 == tabpagenr()
      let line .= '%#TabLineSel#'
    else
      let line .= '%#TabLine#'
    endif
    let line .= ' %{TabLabel(' .. (tab + 1) .. ')} '
  endfor
  let line .= '%#TabLineFill#%T' .. '%=%#StatusLine#' .. ' '
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
  elseif bufname =~ '^term://'
    return 'terminal'
  elseif filetype == 'dirvish'
    return 'dirvish'
  elseif bufname =~ '^fugitive://'
    return 'fugitive://' .. fnamemodify(bufname, ':t')
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
  nnoremap <silent> <m--> <cmd>Lexplore<cr>
endif


" --------------------------------------
" notebook
" --------------------------------------

" notebook directory
let g:projectsdir = '~/notebook/projects/'
let g:todofile = '~/notebook/todo.md'

" toggle the notebook
nnoremap <silent> <m-n> <cmd>call notebook#Project(g:projectsdir)<cr>
nnoremap <silent> <m-t> <cmd>call notebook#Todo(g:todofile)<cr>

" prevent notebook pages from being added to the buffer list
augroup notebook_config
  autocmd!
  autocmd BufNewFile,BufRead ~/notebook/*.txt,~/notebook/*.md setlocal nobuflisted
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
nnoremap <silent> <m-s> <cmd>call term#Toggle(0)<cr>
nnoremap <silent> <m-v> <cmd>call term#Toggle(1)<cr>
nnoremap <silent> <m-w> <cmd>call term#Focus()<cr>

" toggle terminal without leaving terminal insert mode
tnoremap <silent> <m-s> <c-\><c-n><cmd>call term#Toggle(0)<cr>
tnoremap <silent> <m-v> <c-\><c-n><cmd>call term#Toggle(1)<cr>
tnoremap <silent> <m-w> <c-\><c-n><cmd>call term#Focus()<cr>

" use ctrl-r to access registers in terminal insert mode
tnoremap <expr> <c-r> '<c-\><c-n>"' .. nr2char(getchar()) .. 'pi'

" use ctrl-r ctrl-r to reverse-history search
tnoremap <c-r><c-r> <c-r>

augroup terminal_config
  autocmd!

  " prevent the terminal from being added to the buffer list
  autocmd TermOpen * setlocal nobuflisted

  " enable terminal toggling
  autocmd TermOpen * let t:termbuf = bufnr('%')
  autocmd TermOpen * let t:termwin = win_getid()
augroup END


" --------------------------------------
" neovim
" --------------------------------------

" source lua config
lua require('config.init')


" --------------------------------------
" jobfiles
" --------------------------------------

" source init file from jobfiles
runtime job.vim
