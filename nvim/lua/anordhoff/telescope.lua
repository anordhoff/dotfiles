local telescope = require('telescope')
local builtin = require('telescope.builtin')
local actions = require('telescope.actions')

telescope.setup {
  defaults = {
    borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
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
        ['<esc>'] = actions.close,
        ['<Tab>'] = actions.toggle_selection + actions.move_selection_next,
        ['<S-Tab>'] = actions.toggle_selection + actions.move_selection_previous,
        ['<C-x>'] = false,
        ['<C-s>'] = actions.select_horizontal,
      },
      n = {},
    },
    file_ignore_patterns = {
      'tags',
      '.git',
      'vendor',
      'node_modules',
    },
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--hidden',
      '--no-ignore',
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
      case_mode = 'smart_case',
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

-- TODO: telescope bug (https://github.com/nvim-telescope/telescope.nvim/issues/1277)
vim.api.nvim_create_autocmd('BufRead', {
   callback = function()
      vim.api.nvim_create_autocmd('BufWinEnter', {
         once = true,
         command = 'normal! zx'
      })
   end
})
