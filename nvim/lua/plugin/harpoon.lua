local harpoon = require("harpoon")
harpoon:setup()

-- keymaps
vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<leader>ha", function() harpoon:list():replace_at(1) end)
vim.keymap.set("n", "<leader>hr", function() harpoon:list():replace_at(2) end)
vim.keymap.set("n", "<leader>hi", function() harpoon:list():replace_at(3) end)
vim.keymap.set("n", "<leader>ho", function() harpoon:list():replace_at(4) end)

vim.keymap.set("n", "<leader>a", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>r", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>i", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>o", function() harpoon:list():select(4) end)
