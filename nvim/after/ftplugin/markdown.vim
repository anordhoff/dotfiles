setlocal wrap
setlocal showbreak=NONE

" automatically continue lists when creating a newline
setlocal formatoptions=qjwro
setlocal comments+=b:-\ [\ ]
setlocal comments+=b:-\ [x]
setlocal comments-=fb:- comments+=b:-
setlocal comments-=fb:* comments+=b:*

" mark the current item as complete [x] and move to the end of the file
nnoremap <leader>n ddGp3lrx``
