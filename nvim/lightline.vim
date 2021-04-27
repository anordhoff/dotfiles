let s:base0 = [ '#242424', 0 ] " prev. 1d242b
let s:base1 = [ '#2c333b', 0 ]
let s:base2 = [ '#8b959e', 0 ]
let s:base3 = [ '#a3acb5', 0 ]

let s:fg = [ '#606060', 0 ]
let s:bg = [ '#1c1c1c', 0 ]

let s:yellow  = [ '#ab8e38', 0 ]
let s:orange  = [ '#b56f45', 0 ]
let s:red     = [ '#bf5858', 0 ]
let s:magenta = [ '#8b6a9e', 0 ]
let s:blue    = [ '#557b9e', 0 ]
let s:cyan    = [ '#458a8a', 0 ]
let s:green   = [ '#508a50', 0 ]

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

let s:p.normal.left     = [ [ s:base0,  s:blue    ], [ s:base2, s:base0 ] ]
let s:p.normal.right    = [ [ s:base2,  s:base0   ], [ s:base2, s:base0 ] ]
let s:p.inactive.right  = [ [ s:fg,     s:bg  ],     [ s:fg,    s:bg ] ]
let s:p.inactive.left   = [ [ s:fg,     s:bg  ],     [ s:fg,    s:bg ] ]
let s:p.insert.left     = [ [ s:base0,  s:green   ], [ s:base2, s:base0 ] ]
let s:p.replace.left    = [ [ s:base0,  s:magenta ], [ s:base2, s:base0 ] ]
let s:p.visual.left     = [ [ s:base0,  s:cyan    ], [ s:base2, s:base0 ] ]
let s:p.normal.middle   = [ [ s:base0,  s:base0   ] ]
let s:p.inactive.middle = [ [ s:fg,     s:bg  ] ]
let s:p.tabline.left    = [ [ s:base2,  s:base0   ] ]
let s:p.tabline.tabsel  = [ [ s:base3,  s:base1   ] ]
let s:p.tabline.middle  = [ [ s:base2,  s:base0   ] ]
let s:p.tabline.right   = [ [ s:base2,  s:base0   ], [ s:base2, s:base0 ] ]
let s:p.normal.error    = [ [ s:red,    s:base0   ] ]
let s:p.normal.warning  = [ [ s:orange, s:base0   ] ]

let g:lightline#colorscheme#lightline#palette = lightline#colorscheme#flatten(s:p)
