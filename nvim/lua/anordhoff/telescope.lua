local telescope = require('telescope')
local builtin = require('telescope.builtin')

telescope.setup {
  defaults = {
    borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    layout_strategy = 'flex',
    layout_config = {
      flex = {
        flip_columns = 160,
      },
    },
    prompt_prefix = ' $ ',
    preview = {
      treesitter = false,
    },
    color_devicons = false,
    mappings = {
      i = {
        ["<C-s>"] = "select_horizontal",
      },
      n = {
        ["<C-x>"] = false,
        ["<C-s>"] = "select_horizontal",
      },
    },
    file_ignore_patterns = {
      "tags",
      ".git",
      "vendor",
      "node_modules",
    },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
      "--no-ignore",
    },
  },
  pickers = {
    buffers = { sort_mru = true },
    find_files = { hidden=true, no_ignore=true },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
}
telescope.load_extension('fzf')

vim.keymap.set('n', '<leader>ff', builtin.find_files)
vim.keymap.set('n', '<leader>fg', builtin.live_grep)
vim.keymap.set('n', '<leader>fb', builtin.buffers)
vim.keymap.set('n', '<leader>fq', builtin.quickfix)
vim.keymap.set('n', '<leader>fl', builtin.loclist)
vim.keymap.set('n', '<leader>fd', builtin.diagnostics)
vim.keymap.set('n', '<leader>fr', builtin.lsp_references)
vim.keymap.set('n', '<leader>fi', builtin.lsp_implementations)
vim.keymap.set('n', '<leader>ft', builtin.tags)
vim.keymap.set('n', '<leader>fh', builtin.help_tags)
vim.keymap.set('n', '<leader>fm', builtin.keymaps)
