" don't run jobs in a tmux split
let g:dispatch_no_tmux_make = 1
let g:dispatch_no_tmux_start = 1

" TODO(feat): dispatch opening quickfix should not steal focus (can use :cc to move to highlighted error)
" TODO(feat): <m-s>, <m-v>, <m-w> should toggle the term created by :Start (dispatch) if it exists
" TODO(feat): :Start, :Spawn should create a horizonal split that uses the full width of the screen
