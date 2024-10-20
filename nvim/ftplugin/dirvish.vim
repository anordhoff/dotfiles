if exists("b:did_custom_ftplugin")
  finish
endif
let b:did_custom_ftplugin = 1

" unmap default reload mapping
unmap <buffer> R

" unmap default edit mappings
unmap <buffer> i
unmap <buffer> I
unmap <buffer> o
unmap <buffer> O
unmap <buffer> a
unmap <buffer> A

" map `gc` to toggle conceal (<nowait> overrides vim-commentary mappings)
nnoremap <silent><buffer><expr><nowait> gc &cole ? '<cmd>setl cole=0<cr>' : '<cmd>setl cole=2<cr>'

" map `gf` and `g!` to autopopulate filter commands
nnoremap <buffer> gf :g!//d<left><left>
nnoremap <buffer> g! :g//d<left><left>

" map `gh` to hide dot-prefixed files
nnoremap <silent><buffer> gh <cmd>silent keeppatterns g@\v/\.[^\/]+/?$@d _<cr>

" map `gr` to reload
nnoremap <silent><buffer> gr <cmd>Dirvish %<cr>

" map `t` to open file at cursor
nnoremap <silent><buffer> t <cmd>call dirvish#open('edit', 0)<cr>
vnoremap <silent><buffer> t <cmd>call dirvish#open('edit', 0)<cr>

" map `<c-s>` to open in new split
nnoremap <silent><buffer> <c-s> <cmd>call dirvish#open('split', 0)<cr>
vnoremap <silent><buffer> <c-s> <cmd>call dirvish#open('split', 0)<cr>

" map `<c-v>` to open in new vertical split
nnoremap <silent><buffer> <c-v> <cmd>call dirvish#open('vsplit', 0)<cr>
vnoremap <silent><buffer> <c-v> <cmd>call dirvish#open('vsplit', 0)<cr>

" map `<c-t>` to open in new tab
nnoremap <silent><buffer> <c-t> <cmd>call dirvish#open('tabedit', 0)<cr>
vnoremap <silent><buffer> <c-t> <cmd>call dirvish#open('tabedit', 0)<cr>
