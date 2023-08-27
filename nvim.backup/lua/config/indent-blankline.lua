require('indent_blankline').setup {
  enabled = false,
  show_trailing_blankline_indent = false,
}

-- keymaps (follows vim-unimpaired pattern - yog[uidelines])
local opts = {}
vim.keymap.set('n', '[og', ':IndentBlanklineEnable<CR>', opts)
vim.keymap.set('n', ']og', ':IndentBlanklineDisable<CR>', opts)
vim.keymap.set('n', 'yog', ':IndentBlanklineToggle<CR>', opts)
