" ==================== plugins ==================== "
lua << EOF
local ok, _ = pcall(require, 'anordhoff.packer')
if not ok then
  vim.opt.loadplugins = false
end
EOF


" ==================== settings ==================== "
set nohlsearch        " disable search highlighting
set ignorecase        " case-insensitive searching...
set smartcase         " ...but not if the search contains a capital letter
set splitright        " split vertical windows to the right of current window
set splitbelow        " split horizontal windows below current window
set nowrap            " don't wrap text that exceeds width of window
set textwidth=80      " wrap lines at 80 characters when formatting
set scrolloff=5       " keep a minimum of 5 lines above and below the cursor
set fillchars=vert:\| " vertical separator

" TODO: previewheight doesn't do anything
" set previewheight=15

if &loadplugins
  set number nu       " line numbers
  set signcolumn=yes  " always show the sign column
endif

" show possible completions in a pmenu; do not auto-select first option; open preview window
" TODO: stabilize the buffer when preview window is opened or closed
set completeopt=menuone,noselect,preview

" close preview window after insert mode completion is done
" TODO: breaks ctrl-f in commandline mode
" autocmd InsertLeave * pclose

" disable automatic line wrapping and insertion of the current comment leader
augroup formatoptions
  autocmd!
  autocmd BufNewFile,BufRead,FileType,OptionSet * set fo-=t fo-=c fo-=r fo-=o
  autocmd BufNewFile,BufRead,FileType,OptionSet * setlocal fo-=t fo-=c fo-=r fo-=o
augroup END

" disable syntax highlighting when using vimdiff
if &diff
  syntax off
endif

" load custom colorscheme
colorscheme colorscheme

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
  if system("uname") == "Linux\n"
    " preserve yank when exiting
    autocmd VimLeave * call system("xsel -ib", getreg('+'))
  endif
endif


" ==================== mappings ==================== "
" leader key
let mapleader = "\<space>"

" disable neovim default mappings
nunmap Y
nunmap <C-L>
iunmap <C-U>
iunmap <C-W>

" prevent clipboard hijacking
inoremap <C-r>+ <C-r><C-r>+
inoremap <C-r>* <C-r><C-r>*

" toggle search highlighting
nnoremap <leader>/ :set hlsearch!<CR>

" toggle line wrapping
nnoremap <leader>ww :set wrap!<CR>

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


" ==================== statusline ==================== "
set statusline=\ \[%n\]                     " buffer number
set statusline+=\ \ %f                      " filepath
set statusline+=%{GitStatus()}              " git branch
set statusline+=\ \ %{SessionFlag()}        " session flag
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

" git branch and status
function! GitStatus()
  if !&loadplugins || !exists('b:gitsigns_head') || b:gitsigns_head == ''
    return ''
  elseif !exists('b:gitsigns_status') || b:gitsigns_status == ''
    return '  (' . b:gitsigns_head . ')'
  else
    return '  (' . b:gitsigns_head . ' ' . b:gitsigns_status . ')'
  endif
endfunction

" session flag if a session is being recorded or is paused
function! SessionFlag()
  if &loadplugins && exists('*ObsessionStatus')
    return ObsessionStatus('S', 's')
  endif
  return ''
endfunction

" set paste flag if paste has been set
function! PasteFlag()
  if &paste
    if &loadplugins && exists('v:this_session')
      return ',P'
    else
      return 'P'
    endif
  endif
  return ''
endfunction


" ==================== tabline ==================== "
set tabline=%!TabLine()

function! TabLine()
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

function! TabLabel(n)
  let l:buflist = tabpagebuflist(a:n)
  let l:winnr = tabpagewinnr(a:n)
  let l:bufname = bufname(l:buflist[l:winnr - 1])
  if l:bufname == ''
    return '[No Name]'
  elseif l:bufname =~ '/nvim/runtime/doc/'
    return 'help'
  elseif l:bufname =~ '^term://'
    return 'terminal'
  else
    return l:bufname
  endif
endfunction


" ==================== netrw ==================== "
if &loadplugins
  " set the absolute size of netrw windows
  let g:netrw_winsize = -30

  " prevent errors when moving files
  let g:netrw_keepdir = 0

  " enable recursive copies of directories when using the copy command
  let g:netrw_localcopydircmd = 'cp -r'

  " toggle netrw as a project drawer
  nnoremap <leader>n :call ProjectDrawer()<CR>
  function! ProjectDrawer()
    let g:netrw_liststyle = 3
    execute 'Lexplore'
    let g:netrw_liststyle = 0
  endfunction
endif


" ==================== terminal ==================== "
" set the preferred editor to neovim
let $VISUAL='nvim'

" open terminal in a horizontal split, vertical split, or tab
nnoremap <leader>ts :split +term<CR>
nnoremap <leader>tv :vsplit +term<CR>
nnoremap <leader>tt :tabnew +term<CR>

" switch tabs without leaving insert mode
tnoremap <silent> gt <C-\><c-n>:let b:termtab=1<CR>gt
tnoremap <silent> gT <C-\><c-n>:let b:termtab=1<CR>gT

" exit to normal mode using esc / ctrl-[
" NOTE: this causes issues leaving insert mode in a nested neovim session
tnoremap <C-[> <C-\><c-n>

augroup terminal
  autocmd!
  " enter insert mode automatically
  autocmd TermOpen * startinsert
  " disable line numbers
  autocmd TermOpen * setlocal nonumber norelativenumber
  " hide the sign column
  autocmd TermOpen * setlocal signcolumn=no
  " when leaving the terminal tab using gt/gT, enter insert mode when returning
  autocmd TermOpen * let b:termtab = 0
  autocmd BufWinEnter,WinEnter term://*
    \ if b:termtab == 1 |
    \   execute 'startinsert' |
    \   let b:termtab = 0 |
    \ endif
  " hide [Process exited 0] when closing terminal
  " TODO: with this setting, the terminal cannot be used to view results of a process
  autocmd TermClose * if !v:event.status | exe 'bdelete! '..expand('<abuf>') | endif
augroup END
