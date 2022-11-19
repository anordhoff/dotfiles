" TODO: repeat doesn't work for visual substitute
" TODO: highlight flash when using substitute over range

" substitute
nmap s <plug>(SubversiveSubstitute)
xmap s <plug>(SubversiveSubstitute)
nmap ss <plug>(SubversiveSubstituteLine)
nmap S <plug>(SubversiveSubstituteToEndOfLine)

" substitute over range
nmap gs <plug>(SubversiveSubstituteRange)
xmap gs <plug>(SubversiveSubstituteRange)
nmap gss <plug>(SubversiveSubstituteWordRange)
