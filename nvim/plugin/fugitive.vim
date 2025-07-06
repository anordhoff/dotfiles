" TODO(feat): change the following keymaps:
"   - blame window: gq -> q
"                    o -> ctrl-s
"             unmapped -> ctrl-v
"                    O -> ctrl-t
"                 <CR> -> a (maybe)
"   - navigation:    o -> ctrl-s
"                   gO -> ctrl-v
"                    O -> ctrl-t
"                 <CR> -> a (maybe)

nnoremap g<space> :Git<space>
nnoremap g<cr> <cmd>Git<cr>

" use :Glog to view the revision history of the current file
command Glog :0Gllog

" use git-jump from within vim
command -bar -nargs=* GJump cexpr system('git jump --stdout ' . expand(<q-args>))
