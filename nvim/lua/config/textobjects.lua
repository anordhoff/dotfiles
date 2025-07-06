local textobjects = require("nvim-treesitter-textobjects")
local select = require('nvim-treesitter-textobjects.select')
local swap = require('nvim-treesitter-textobjects.swap')
local move = require("nvim-treesitter-textobjects.move")

textobjects.setup {
  select = {
    lookahead = true,
    include_surrounding_whitespace = false,
    selection_modes = {
      ['@function.inner'] = 'v',
      ['@function.outer'] = 'V',
      ['@class.inner'] = 'v',
      ['@class.outer'] = 'V',
      ['@conditional.inner'] = 'v',
      ['@conditional.outer'] = 'V',
      ['@loop.inner'] = 'v',
      ['@loop.outer'] = 'V',
    },
  },
  move = {
    set_jumps = true,
  },
}

-- select keymaps
vim.keymap.set({ "x", "o" }, "if", function() select.select_textobject("@function.inner", "textobjects") end)
vim.keymap.set({ "x", "o" }, "af", function() select.select_textobject("@function.outer", "textobjects") end)
vim.keymap.set({ "x", "o" }, "ic", function() select.select_textobject("@class.inner", "textobjects") end)
vim.keymap.set({ "x", "o" }, "ac", function() select.select_textobject("@class.outer", "textobjects") end)
vim.keymap.set({ "x", "o" }, "iC", function() select.select_textobject("@conditional.inner", "textobjects") end)
vim.keymap.set({ "x", "o" }, "aC", function() select.select_textobject("@conditional.outer", "textobjects") end)
vim.keymap.set({ "x", "o" }, "iL", function() select.select_textobject("@loop.inner", "textobjects") end)
vim.keymap.set({ "x", "o" }, "aL", function() select.select_textobject("@loop.outer", "textobjects") end)

-- swap keymaps
vim.keymap.set("n", "<leader>an", function() swap.swap_next "@parameter.inner" end)
vim.keymap.set("n", "<leader>al", function() swap.swap_previous "@parameter.inner" end)

-- move keymaps
vim.keymap.set({ "n", "x", "o" }, "]]", function() move.goto_next_start("@function.outer", "textobjects") end)
vim.keymap.set({ "n", "x", "o" }, "][", function() move.goto_next_end("@function.outer", "textobjects") end)
vim.keymap.set({ "n", "x", "o" }, "[[", function() move.goto_previous_start("@function.outer", "textobjects") end)
vim.keymap.set({ "n", "x", "o" }, "[]", function() move.goto_previous_end("@function.outer", "textobjects") end)
