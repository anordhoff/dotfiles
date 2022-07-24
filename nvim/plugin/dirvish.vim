" disable netrw
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwSettings = 1
let g:loaded_netrwFileHandlers = 1

" replace netrw `Explore` commands
command! -nargs=? -complete=dir Explore Dirvish <args>
command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>

" use relative directories; sort directories first
let g:dirvish_relative_paths = 1
let g:dirvish_mode = ':sort | sort ,^\v(.*[\/])|\ze,'

" open the current directory
nnoremap <silent> _ :Dirvish<CR>

" TODO: show preview with `p` in a preview window
" TODO: argslist is buggy when g:dirvish_relative_paths = 1
augroup dirvish_config
	autocmd!
	autocmd Filetype dirvish setlocal signcolumn=no

	" unmap default dirvish_arglist mapping
	autocmd Filetype dirvish silent! unmap <buffer> x
	autocmd Filetype dirvish silent! unmap <buffer> dax

	" unmap default reload mapping
	autocmd Filetype dirvish silent! unmap <buffer> R

	" unmap default edit mappings
	autocmd Filetype dirvish silent! unmap <buffer> i
	autocmd Filetype dirvish silent! unmap <buffer> I
	autocmd Filetype dirvish silent! unmap <buffer> o
	autocmd Filetype dirvish silent! unmap <buffer> O
	autocmd Filetype dirvish silent! unmap <buffer> a
	autocmd Filetype dirvish silent! unmap <buffer> A

	" map `gf` to autopopulated filter command
	autocmd Filetype dirvish nnoremap <buffer> gf :g//d<left><left>

	" map `gr` to reload
	autocmd Filetype dirvish nnoremap <silent><buffer> gr :<C-U>Dirvish %<CR>

	" map `gh` to hide dot-prefixed files
	autocmd Filetype dirvish nnoremap <silent><buffer> gh :silent keeppatterns g/^\..*/d<CR>

	" map `a` to dirvish_arg
	autocmd Filetype dirvish nnoremap <silent><buffer> a <Plug>(dirvish_arg)
	autocmd Filetype dirvish xnoremap <silent><buffer> a <Plug>(dirvish_arg)
	autocmd Filetype dirvish nnoremap <silent><buffer> da :arglocal<Bar>silent! argdelete *<Bar>echo 'arglist: cleared'<CR>

	" map `t` to open file at cursor
	autocmd Filetype dirvish nnoremap <silent><buffer> t :call dirvish#open('edit', 0)<CR>
	autocmd Filetype dirvish xnoremap <silent><buffer> t :call dirvish#open('edit', 0)<CR>

	" map `<C-s>` to open in new split
	autocmd Filetype dirvish nnoremap <silent><buffer> <C-s> :call dirvish#open('split', 0)<CR>
	autocmd Filetype dirvish xnoremap <silent><buffer> <C-s> :call dirvish#open('split', 0)<CR>

	" map `<C-v>` to open in new vertical split
	autocmd Filetype dirvish nnoremap <silent><buffer> <C-v> :call dirvish#open('vsplit', 0)<CR>
	autocmd Filetype dirvish xnoremap <silent><buffer> <C-v> :call dirvish#open('vsplit', 0)<CR>

	" map `<C-t>` to open in new tab
	autocmd Filetype dirvish nnoremap <silent><buffer> <C-t> :call dirvish#open('tabedit', 0)<CR>
	autocmd Filetype dirvish xnoremap <silent><buffer> <C-t> :call dirvish#open('tabedit', 0)<CR>
augroup END
