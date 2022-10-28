" replace netrw `Explore` commands
command! -nargs=? -complete=dir Explore Dirvish <args>
command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>

" sort directories first
let g:dirvish_mode = ':sort ,^.*[\/],'

" open the current working directory
" TODO: doesn't work
nnoremap <silent> _ :Dirvish<CR>

" TODO: take a count
" open the [count]th parent directory in a new window
nnoremap <silent> <leader>f :<c-u>execute v:count1 . 'YY'<CR>
" nnoremap <silent> <leader>s <Plug>(dirvish_split_up)
" nnoremap <silent> <leader>s :<C-U>execute v:count . <Plug>(dirvish_split_up)<CR>
nnoremap <silent> <leader>v <Plug>(dirvish_vsplit_up)

augroup dirvish_config
  autocmd!

  " use dirvish instead of netrw when opening a directory with vim
  " NOTE: dirvish should handle this without explicitly adding an autocmd
  autocmd VimEnter * if exists('#FileExplorer') | exe 'au! FileExplorer *' | endif

  " unmap default reload mapping
  autocmd Filetype dirvish silent! unmap <buffer> R

  " unmap default edit mappings
  autocmd Filetype dirvish silent! unmap <buffer> i
  autocmd Filetype dirvish silent! unmap <buffer> I
  autocmd Filetype dirvish silent! unmap <buffer> o
  autocmd Filetype dirvish silent! unmap <buffer> O
  autocmd Filetype dirvish silent! unmap <buffer> a
  autocmd Filetype dirvish silent! unmap <buffer> A

  " map `gc` to toggle conceal (<nowait> overrides vim-commentary mappings)
  autocmd Filetype dirvish nnoremap <silent><buffer><expr><nowait> gc &cole ? ':setl cole=0<CR>' : ':setl cole=2<CR>'

  " map `gf` to autopopulated filter command
  autocmd Filetype dirvish nnoremap <buffer> gf :g//d<left><left>

  " map `gh` to hide dot-prefixed files
  autocmd Filetype dirvish nnoremap <silent><buffer> gh :silent keeppatterns g@\v/\.[^\/]+/?$@d _<CR>

  " map `gr` to reload
  autocmd Filetype dirvish nnoremap <silent><buffer> gr :<C-U>Dirvish %<CR>

  " map `a` to open file at cursor
  autocmd Filetype dirvish nnoremap <silent><buffer> a :call dirvish#open('edit', 0)<CR>
  autocmd Filetype dirvish xnoremap <silent><buffer> a :call dirvish#open('edit', 0)<CR>

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
