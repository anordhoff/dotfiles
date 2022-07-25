" ==================== settings ==================== "
set number             " line numbers
set noincsearch        " don't execute search until hitting enter
set noshowmode         " hide the mode from the bottom row
set ignorecase         " case-insensitive searching...
set smartcase          " ...but not if the search contains a capital letter
set nowrap             " don't wrap text that exceeds width of window
set linebreak          " wrap lines at a character in 'breakat'
set breakindent        " visually indent wrapped lines
set list               " display listchars
set showbreak=\ ..\    " add ' .. ' to the start of wrapped lines
set fillchars=vert:\|  " use the pipe symbol as a vertical separator
set textwidth=79       " wrap lines at 79 characters when formatting
set scrolloff=2        " keep a minimum of 2 lines above and below the cursor
set sidescrolloff=8    " keep a minimum of 8 columns before & after the cursor
set noexpandtab        " use tabs instead of spaces
set ts=4 sw=4          " set the default tab size to 4
set shell=/bin/zsh\ -i " interactive command mode shell (for aliases)

" show trailing spaces
set listchars=tab:\ \ ,trail:-

" don't show trailing spaces while in insert mode
augroup listchars
	autocmd!
	autocmd InsertEnter * setlocal listchars-=trail:-
	autocmd InsertLeave * setlocal listchars+=trail:-
augroup END

" load custom colorscheme
colorscheme colorscheme

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

" enable the cursorline when in diff mode
if &diff | set cursorline | endif
augroup diff
	autocmd!
	autocmd BufNewFile,BufRead * if &diff | let &cursorline=1 | endif
	autocmd OptionSet diff let &cursorline=v:option_new
	autocmd BufHidden * set nocursorline
augroup END

" enable spellchecking for text files, markdown, and git commit messages
augroup spellcheck
	autocmd!
	autocmd FileType text,markdown,gitcommit setlocal spell
augroup END

" Enable filetype.lua for better performance (NOTE: experimental)
let g:do_filetype_lua = 1
let g:did_load_filetypes = 0


" ==================== keymaps ==================== "
" leader key
let mapleader = "\<space>"

" prevent clipboard hijacking
inoremap <C-r>+ <C-r><C-r>+
inoremap <C-r>* <C-r><C-r>*

" clear the specified register
nnoremap <leader>cr :call setreg('', [])<Left><Left><Left><Left><Left><Left>

" get highlight group under the cursor
nnoremap <silent> <leader>H :call SynGroup()<CR>
function! SynGroup()
	for i1 in synstack(line('.'), col('.'))
		let i2 = synIDtrans(i1)
		echo synIDattr(i1, 'name') '->' synIDattr(i2, 'name')
	endfor
endfunction

" maximize (toggle) the current window
nnoremap <silent> <leader>z :call MaximizeWindowToggle()<CR>
function! MaximizeWindowToggle()
	" initialize the maximized variable
	if !exists('t:maximized')
		let t:maximized = 0
	endif

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
set statusline=\ \[%n\]                      " buffer number
set statusline+=\ \ %f                       " filepath
set statusline+=%{GitStatus()}               " git branch
set statusline+=\ \ %{NopluginFlag()}        " session flag
set statusline+=%{SessionFlag()}             " session flag
set statusline+=%{PasteFlag()}               " paste flag
set statusline+=%H%W%R%M                     " help/preview/read-only/modified flags
set statusline+=%=\ \ \ %c%V\ \ :\ \ %2l\/%L " byte index, virtual column number; line number
set statusline+=%{Filetype()}                " filetype

augroup statusline
	autocmd!
	" quickfix/location list
	autocmd Filetype qf setlocal statusline=\ \[%n\]\ \ %l/%L\ lines%=%q\ 
	" terminal
	autocmd TermOpen * setlocal statusline=\ \[%n\]\ \ terminal\ \ %{NopluginFlag()}%{PasteFlag()}%H%W%R%M\ \ %{TerminalMode()}
augroup END

" correct padding when there is no filetype
function! Filetype()
	if &filetype == ''
		return ' '
	else
		return '  [' . &filetype . '] '
	endif
endfunction

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

" set 'insert' flag if terminal buffer is in 'terminal' mode
function! TerminalMode()
	if mode() == 't'
		return 'insert'
	else
		return ''
	endif
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


" ==================== notes ==================== "
let s:notesdir = '~/notes'

" toggle the notebook
nnoremap <silent> <leader>n :call NotesToggle()<CR>
function! NotesToggle()
	" initialize the notesbuf and noteswin variables
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
			exec 'split ' . s:notesdir
			let t:notesbuf = bufnr('%')
		endtry
		let t:noteswin = win_getid()
	endif
endfunction

augroup notes
	autocmd!
	" prevent notes from being added to the buffer list
	autocmd BufNewFile,BufRead ~/notes/*.txt,~/notes/*.md setlocal nobuflisted
augroup END


" ==================== terminal ==================== "
" TODO: return to same :term when closing nested nvim session (ie <C-x><C-e>)
" TODO: git mergetool with --remote
" TODO: implement an i_CTRL-O command in terminal readline

" set the preferred editor to use the current session's RPC server
let $VISUAL="nvim --server " . v:servername . " --remote"
let $EDITOR="nvim --server " . v:servername . " --remote"

" exit to normal mode using ctrl-[ / esc
tnoremap <C-[> <C-\><C-n>
tnoremap <esc> <C-\><C-n>

" open terminal in a horizontal split, vertical split, or tab
nnoremap <silent> <A-s> :call TermToggle(0)<CR>
nnoremap <silent> <A-v> :call TermToggle(1)<CR>
nnoremap <silent> <leader>t :tabnew +term<CR>

" toggle terminal without leaving terminal insert mode
tnoremap <silent> <A-s> <C-\><C-n>:call TermToggle(0)<CR>
tnoremap <silent> <A-v> <C-\><C-n>:call TermToggle(1)<CR>
tnoremap <silent> gt <C-\><C-n>:let b:termtab=1<CR>gt
tnoremap <silent> gT <C-\><C-n>:let b:termtab=1<CR>gT

" use <A-r> to access registers in terminal insert mode
tnoremap <expr> <A-r> '<C-\><C-N>"'.nr2char(getchar()).'pi'

" toggle a horizontal/vertical terminal split
function! TermToggle(vsplit)
	" initialize the termbuf and termwin variables
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


" ==================== plugins ==================== "
if &loadplugins
	lua require('impatient')
	lua require('anordhoff.leap')
	lua require('anordhoff.lspconfig')
	lua require('anordhoff.telescope')
	lua require('anordhoff.treesitter')
endif
