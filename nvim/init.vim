" ==================== plugins ==================== "
lua << EOF
pcall(require, 'impatient')
local ok, _ = pcall(require, 'anordhoff.packer')
if not ok then
  vim.opt.loadplugins = false
end
EOF


" ==================== settings ==================== "
set number nu         " line numbers
set noincsearch       " don't execute search until hitting enter
set noshowmode        " hide the mode from the bottom row
set ignorecase        " case-insensitive searching...
set smartcase         " ...but not if the search contains a capital letter
set nowrap            " don't wrap text that exceeds width of window
set linebreak         " wrap lines at a character in 'breakat'
set breakindent       " visually indent wrapped lines
set showbreak=\ ..\   " add ' .. ' to the start of wrapped lines
set fillchars=vert:\| " use the pipe symbol as a vertical separator
set textwidth=79      " wrap lines at 79 characters when formatting
set scrolloff=2       " keep a minimum of 2 lines above and below the cursor
set sidescrolloff=8   " keep a minimum of 8 columns before and after the cursor

" add 'extends' and 'precedes' to default listchars
set listchars=tab:>\ ,trail:-,nbsp:+,extends:>,precedes:<

" only show the sign column if running with plugins enabled
if &loadplugins | set signcolumn=yes | endif

" show possible completions in a pmenu; insert longest common text of matches
" TODO: stabilize the buffer when preview window is opened or closed
set completeopt=menu,longest,preview
set pumheight=10

" close preview window after closing pmenu or choosing a selection
autocmd CompleteDone * if pumvisible() == 0 | pclose | endif

" use a wildmenu for command line completion
set wildoptions=tagfile
set wildmode=longest:full,full
set wildignorecase

" disable automatic line wrapping for non-comment text; disable insertion of
" the current comment leader when creating a new line
augroup formatoptions
  autocmd!
  autocmd BufNewFile,BufRead,FileType,OptionSet * set fo-=t fo-=r fo-=o
  autocmd BufNewFile,BufRead,FileType,OptionSet * setlocal fo-=t fo-=r fo-=o
augroup END

" disable syntax highlighting when using vimdiff
if &diff | syntax off | endif

" load custom colorscheme
colorscheme colorscheme

" enable spellchecking for markdown, git commit messages
augroup spellcheck
  autocmd!
  autocmd FileType gitcommit,markdown setlocal spell
augroup END

" enable proper yanking/pasting to/from clipboard on Linux
if $WAYLAND_DISPLAY != ""
  " wayland clipboard provider that strips carriage returns (GTK3 issue)
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


" ==================== keymaps ==================== "
" leader key
let mapleader = "\<space>"

" prevent clipboard hijacking
inoremap <C-r>+ <C-r><C-r>+
inoremap <C-r>* <C-r><C-r>*

" get highlight group under the cursor
nnoremap <silent> <leader>H :call SynGroup()<CR>
function! SynGroup()                                                            
  for i1 in synstack(line('.'), col('.'))
    let i2 = synIDtrans(i1)
    echo synIDattr(i1, 'name') '->' synIDattr(i2, 'name')
  endfor
endfunction

" toggle the notebook
nnoremap <silent> <leader>n :call NotesToggle()<CR>
let g:notes = 0
function! NotesToggle()
  if g:notes
    if bufnr('%') == g:notes
      bdelete
      let g:notes = 0
    else
      exec 'buffer ' . g:notes
    endif
  else
    edit ~/notes/notes.md
    let g:notes = bufnr('%')
  endif
endfunction

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

" toggle the quickfix list
nnoremap <silent> <leader>q :call QuickfixListToggle()<CR>
function! QuickfixListToggle()
  if getqflist({'winid': 0}).winid
    cclose
  else
    copen
  endif
endfunction

" toggle the location list
nnoremap <silent> <leader>l :call LocationListToggle()<CR>
function! LocationListToggle()
  try
    if getloclist(0, {'winid': 0}).winid
      lclose
    else
      lopen
    endif
  catch 'E776'
    echohl ErrorMsg | echo 'E776: No location list' | echohl None
  endtry
endfunction


" ==================== statusline ==================== "
set statusline=\ \[%n\]                    " buffer number
set statusline+=\ \ %f                     " filepath
set statusline+=%{GitStatus()}             " git branch
set statusline+=\ \ %{NopluginFlag()}      " session flag
set statusline+=%{SessionFlag()}           " session flag
set statusline+=%{PasteFlag()}             " paste flag
set statusline+=%H%W%R%M                   " help/preview/read-only/modified flags
set statusline+=%=\ \ %c%V\ \ :\ \ %2l\/%L " byte index, virtual column number; line number
set statusline+=\ \ %y\                    " filetype

augroup statusline
  autocmd!
  " quickfix/location list
  autocmd Filetype qf setlocal statusline=\ \[%n\]\ \ %l/%L\ lines%=%q\ 
  " TODO: remove netrw
  " netrw
  " autocmd Filetype netrw setlocal statusline=\ \[%n\]\ \ netrw\ \ %{PasteFlag()}%H%W%R%M
  " terminal
  autocmd TermOpen * setlocal statusline=\ \[%n\]\ \ terminal\ \ %{NopluginFlag()}%{PasteFlag()}%H%W%R%M
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

" noplugin flag if running with --noplugin set
function! NopluginFlag()
  if !&loadplugins
    return 'NP'
  endif
  return ''
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
    elseif !&loadplugins
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

" TODO: buffers opened with dirvish have absolute path rather than relative
function! TabLabel(n)
  let l:buflist = tabpagebuflist(a:n)
  let l:winnr = tabpagewinnr(a:n)
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
  " TODO: remove netrw
  " elseif l:bufname =~ '^netrw://'
  "   return 'netrw'
  else
    return l:bufname
  endif
endfunction


" ==================== netrw ==================== "
" TODO: remove netrw
" if &loadplugins
"   " set the absolute size of netrw windows
"   let g:netrw_winsize = -28
"
"   " prevent errors when moving files
"   let g:netrw_keepdir = 0
"
"   " enable recursive copies of directories when using the copy command
"   let g:netrw_localcopydircmd = 'cp -r'
"
"   " toggle netrw as a project drawer
"   nnoremap <leader>n :call ProjectDrawer()<CR>
"   function! ProjectDrawer()
"     let g:netrw_liststyle = 3
"     execute 'Lexplore'
"     let g:netrw_liststyle = 0
"   endfunction
" endif


" ==================== terminal ==================== "
" TODO: return to same :term when closing nested nvim session (ie <C-x><C-e>)
" TODO: git mergetool with --remote

" set the preferred editor to use the current session's RPC server
let $VISUAL="nvim --server $NVIM_LISTEN_ADDRESS --remote"

" exit to normal mode using ctrl-[ / esc
tnoremap <C-[> <C-\><C-n>
tnoremap <esc> <C-\><C-n>

" open terminal in a horizontal split, vertical split, or tab
nnoremap <A-s> :call TermToggle(0)<CR>
nnoremap <A-v> :call TermToggle(1)<CR>
nnoremap <leader>t :call TermTab()<CR>

" toggle terminal without leaving terminal insert mode
tnoremap <silent> <A-s> <C-\><C-n>:call TermToggle(0)<CR>
tnoremap <silent> <A-v> <C-\><C-n>:call TermToggle(1)<CR>
tnoremap <silent> gt <C-\><C-n>:let b:termtab=1<CR>gt
tnoremap <silent> gT <C-\><C-n>:let b:termtab=1<CR>gT

" use <A-r> to access registers in terminal insert mode
tnoremap <expr> <A-r> '<C-\><C-N>"'.nr2char(getchar()).'pi'

" toggle a horizontal/vertical terminal split
let g:termbuf = 0
let g:termwin = 0
function! TermToggle(vsplit)
  if win_gotoid(g:termwin)
    hide
  else
    try
      if a:vsplit
        exec 'vertical sbuffer ' . g:termbuf
      else
        exec 'sbuffer ' . g:termbuf
      endif
      startinsert!
    catch
      if a:vsplit
        exec 'vsplit +term'
      else
        exec 'split +term'
      endif
      let g:termbuf = bufnr('%')
    endtry
    let g:termwin = win_getid()
  endif
endfunction

" open existing terminal buffer (or new buffer) in a tab
function! TermTab()
  try
    exec 'tab sbuffer ' . g:termbuf
    let g:termbuf = 0
    let g:termwin = 0
    startinsert!
  catch
    exec 'tabnew +term'
  endtry
endfunction

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
    \ if b:termtab |
    \   execute 'startinsert!' |
    \   let b:termtab = 0 |
    \ endif
augroup END


" ==================== jobfiles ==================== "
runtime job.vim
