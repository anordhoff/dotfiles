let s:base03  = [ '#242424', 0 ] " prev. 1d242b
let s:base02  = [ '#2c333b', 0 ]
let s:base01  = [ '#616b75', 0 ]
let s:base00  = [ '#77808a', 0 ]
let s:base0   = [ '#8b959e', 0 ]
let s:base1   = [ '#a3acb5', 0 ]
let s:base2   = [ '#dde6f0', 0 ]
let s:base3   = [ '#f0f8ff', 0 ]

let s:yellow  = [ '#ab8e38', 0 ]
let s:orange  = [ '#b56f45', 0 ]
let s:red     = [ '#bf5858', 0 ]
let s:magenta = [ '#8b6a9e', 0 ]
let s:blue    = [ '#557b9e', 0 ]
let s:cyan    = [ '#458a8a', 0 ]
let s:green   = [ '#508a50', 0 ]

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

let s:p.normal.left     = [ [ s:base03, s:blue    ], [ s:base0, s:base03 ] ]
let s:p.normal.right    = [ [ s:base0,  s:base03  ], [ s:base0, s:base03 ] ]
let s:p.inactive.right  = [ [ s:base0,  s:base03  ], [ s:base0, s:base03 ] ]
let s:p.inactive.left   = [ [ s:base0,  s:base03  ], [ s:base0, s:base03 ] ]
let s:p.insert.left     = [ [ s:base03, s:green   ], [ s:base0, s:base03 ] ]
let s:p.replace.left    = [ [ s:base03, s:magenta ], [ s:base0, s:base03 ] ]
let s:p.visual.left     = [ [ s:base03, s:cyan    ], [ s:base0, s:base03 ] ]
let s:p.normal.middle   = [ [ s:base0,  s:base03  ] ]
let s:p.inactive.middle = [ [ s:base0,  s:base03  ] ]
let s:p.tabline.left    = [ [ s:base0,  s:base03  ] ]
let s:p.tabline.tabsel  = [ [ s:base1,  s:base02  ] ]
let s:p.tabline.middle  = [ [ s:base0,  s:base03  ] ]
let s:p.tabline.right   = [ [ s:base0,  s:base03  ], [ s:base0, s:base03 ] ]
let s:p.normal.error    = [ [ s:red,    s:base03  ] ]
let s:p.normal.warning  = [ [ s:orange, s:base03  ] ]

let g:lightline#colorscheme#lightline#palette = lightline#colorscheme#flatten(s:p)
