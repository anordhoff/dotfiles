local opts = { noremap=true, silent=true }

vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>lua require("telescope.builtin").find_files()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>lua require("telescope.builtin").live_grep()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>lua require("telescope.builtin").buffers()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>fq', '<cmd>lua require("telescope.builtin").quickfix()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>fl', '<cmd>lua require("telescope.builtin").loclist()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>fe', '<cmd>lua require("telescope.builtin").diagnostics()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>fr', '<cmd>lua require("telescope.builtin").lsp_references()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>fh', '<cmd>lua require("telescope.builtin").help_tags()<CR>', opts)
