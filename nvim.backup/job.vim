" bogie
augroup ftdetect
  autocmd!
  autocmd BufNewFile,BufRead Bogiefile,Gearsfile,Avenuefile,Gearspec setlocal filetype=yaml
augroup END
