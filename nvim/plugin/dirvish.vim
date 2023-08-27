" TODO: change dirvish mapping 'x' to something else so I can use leap

" sort directories first
let g:dirvish_mode = ':sort ,^.*[\/],'

" open the current working directory
nnoremap <silent> _ :Dirvish .<cr>

" open the [count]th parent directory in a new window
nmap <silent> <leader>s <plug>(dirvish_split_up)
nmap <silent> <leader>v <plug>(dirvish_vsplit_up)

augroup dirvish_config
  autocmd!

  " use dirvish instead of netrw when opening a directory with vim
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
  autocmd Filetype dirvish nnoremap <silent><buffer><expr><nowait> gc &cole ? ':setl cole=0<cr>' : ':setl cole=2<cr>'

  " map `gf` to autopopulated filter command
  autocmd Filetype dirvish nnoremap <buffer> gf :g//d<left><left>

  " map `gh` to hide dot-prefixed files
  autocmd Filetype dirvish nnoremap <silent><buffer> gh :silent keeppatterns g@\v/\.[^\/]+/?$@d _<cr>

  " map `gr` to reload
  autocmd Filetype dirvish nnoremap <silent><buffer> gr :<c-u>Dirvish %<cr>

  " map `a` to open file at cursor
  autocmd Filetype dirvish nnoremap <silent><buffer> a :call dirvish#open('edit', 0)<cr>
  autocmd Filetype dirvish xnoremap <silent><buffer> a :call dirvish#open('edit', 0)<cr>

  " map `<c-s>` to open in new split
  autocmd Filetype dirvish nnoremap <silent><buffer> <c-s> :call dirvish#open('split', 0)<cr>
  autocmd Filetype dirvish xnoremap <silent><buffer> <c-s> :call dirvish#open('split', 0)<cr>

  " map `<c-v>` to open in new vertical split
  autocmd Filetype dirvish nnoremap <silent><buffer> <c-v> :call dirvish#open('vsplit', 0)<cr>
  autocmd Filetype dirvish xnoremap <silent><buffer> <c-v> :call dirvish#open('vsplit', 0)<cr>

  " map `<c-t>` to open in new tab
  autocmd Filetype dirvish nnoremap <silent><buffer> <c-t> :call dirvish#open('tabedit', 0)<cr>
  autocmd Filetype dirvish xnoremap <silent><buffer> <c-t> :call dirvish#open('tabedit', 0)<cr>
augroup END
