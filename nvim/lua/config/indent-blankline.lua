require('ibl').setup {
  enabled = false,
  indent = {
    char = "▏",
    tab_char = "▏",
  },
  scope = {
    enabled = false,
  },
}

-- keymaps (follows vim-unimpaired pattern - yog[uidelines])
local opts = {}
vim.keymap.set('n', '[og', ':IBLEnable<CR>', opts)
vim.keymap.set('n', ']og', ':IBLDisable<CR>', opts)
vim.keymap.set('n', 'yog', ':IBLToggle<CR>', opts)
