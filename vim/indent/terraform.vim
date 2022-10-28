" https://github.com/hashivim/vim-terraform/blob/master/indent/terraform.vim
" Only load this file if no other indent file was loaded
if exists('b:did_indent')
  finish
endif
runtime! indent/hcl.vim
