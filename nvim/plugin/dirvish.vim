" disable netrw
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwSettings = 1
let g:loaded_netrwFileHandlers = 1

" replace netrw `Explore` commands
command! -nargs=? -complete=dir Explore Dirvish <args>
command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>

" sort directories first
let g:dirvish_mode = ':sort | sort ,^.*/,'

" global mappings
" nnoremap <silent> - :Dirvish %<CR>
nnoremap <silent> _ :Dirvish<CR>

" filter the buffer and reset paths from absolute to relative
function! DirvishFilter()
  let cmd = input('', ":g//d\<left>\<left>")
  exe cmd
  setl cole=3 " TODO: why isn't this running?
endfunction

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

  " map `gr` to reload
  autocmd Filetype dirvish nnoremap <silent><buffer> gr :<C-U>Dirvish %<CR>

  " map `gh` to hide dot-prefixed files
  autocmd Filetype dirvish nnoremap <silent><buffer> gh :silent keeppatterns g@\v/\.[^\/]+/?$@d _<cr>:setl cole=3<cr>

  " map `gf` to autopopulated filter command
  autocmd Filetype dirvish nnoremap <silent><buffer> gf :call DirvishFilter()<CR>

  " map `t` to dirvish_arg
  autocmd Filetype dirvish nnoremap <silent><buffer> a <Plug>(dirvish_arg)
  autocmd Filetype dirvish xnoremap <silent><buffer> a <Plug>(dirvish_arg)
  autocmd Filetype dirvish nnoremap <silent><buffer> da :arglocal<Bar>silent! argdelete *<Bar>echo 'arglist: cleared'<Bar>Dirvish %<CR>

  " map `e` to open file at cursor
  autocmd Filetype dirvish nnoremap <silent><buffer> e :call dirvish#open('edit', 0)<CR>
  autocmd Filetype dirvish xnoremap <silent><buffer> e :call dirvish#open('edit', 0)<CR>

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
