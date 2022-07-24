" prevent collisions with leap.nvim
let g:surround_no_mappings = 1

" update VSurround from S to gs
nmap ds  <Plug>Dsurround
nmap cs  <Plug>Csurround
nmap cS  <Plug>CSurround
nmap ys  <Plug>Ysurround
nmap yS  <Plug>YSurround
nmap yss <Plug>Yssurround
nmap ySs <Plug>YSsurround
nmap ySS <Plug>YSsurround
xmap gs  <Plug>VSurround
xmap gS  <Plug>VgSurround

" enable <C-S>s and <C-S>S in insert mode
" if !exists("g:surround_no_insert_mappings") || !g:surround_no_insert_mappings
" 	if !hasmapto("<Plug>Isurround", "i") && mapcheck("<C-S>", "i") == ""
" 		imap <C-S>s <Plug>Isurround
" 		imap <C-S>S <Plug>ISurround
" 	endif
" endif
