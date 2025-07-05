setlocal wrap
setlocal showbreak=NONE

" automatically add a bullet when creating a newline
setlocal formatoptions=qjwro
setlocal comments-=fb:- comments+=:-
setlocal comments-=fb:* comments+=:*

" mark the current item as complete [x] and move to the end of the file
nnoremap <leader>aa ddGp3lrx``
