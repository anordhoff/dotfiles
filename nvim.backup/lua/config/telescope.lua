local telescope = require('telescope')
local builtin = require('telescope.builtin')
local actions = require('telescope.actions')

telescope.load_extension('fzf')

local function smart_send_to_qflist(prompt_bufnr)
   actions.smart_send_to_qflist(prompt_bufnr)
   vim.cmd('botright copen')
   vim.cmd('wincmd p')
end

local function smart_send_to_loclist(prompt_bufnr)
   actions.smart_send_to_loclist(prompt_bufnr)
   vim.cmd('lopen')
   vim.cmd('wincmd p')
end

telescope.setup {
  defaults = {
    borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
    layout_strategy = 'flex',
    layout_config = {
      flex = {
        flip_columns = 160,
      },
    },
    preview = {
      treesitter = false,
    },
    color_devicons = false,
    mappings = {
      i = {
        ['<esc>'] = actions.close,
        ['<c-x>'] = false,
        ['<c-s>'] = actions.select_horizontal,
        ['<tab>'] = actions.toggle_selection + actions.move_selection_next,
        ['<s-tab>'] = actions.toggle_selection + actions.move_selection_previous,
        ["<m-q>"] = false,
        ["<c-q>"] = smart_send_to_qflist,
        ["<c-l>"] = smart_send_to_loclist,
      },
      n = {},
    },
    file_ignore_patterns = {
      'tags',
      '.git',
      'bin',
      'vendor',
      'node_modules',
      'package/opt',
      'package/start',
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

-- add line numbers to telescope preview buffers
local telescope_group = vim.api.nvim_create_augroup('telescope', { clear = true })
vim.api.nvim_create_autocmd('User', {
  group = telescope_group,
  callback = function()
    vim.opt_local.number = true
  end,
  pattern = 'TelescopePreviewerLoaded'
})

-- mappings
local opts = { silent = true }
vim.keymap.set('n', '<leader>ff', builtin.find_files, opts)
vim.keymap.set('n', '<leader>fg', builtin.live_grep, opts)
vim.keymap.set('n', '<leader>fb', builtin.buffers, opts)
vim.keymap.set('n', '<leader>fq', builtin.quickfix, opts)
vim.keymap.set('n', '<leader>fl', builtin.loclist, opts)
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, opts)
vim.keymap.set('n', '<leader>fr', builtin.lsp_references, opts)
vim.keymap.set('n', '<leader>fi', builtin.lsp_implementations, opts)
vim.keymap.set('n', '<leader>ft', builtin.tags, opts)
vim.keymap.set('n', '<leader>fh', builtin.help_tags, opts)
vim.keymap.set('n', '<leader>fm', builtin.keymaps, opts)
vim.keymap.set('n', '<leader>fc', builtin.commands, opts)

-- NOTE: telescope bug (https://github.com/nvim-telescope/telescope.nvim/issues/1277)
vim.api.nvim_create_autocmd('BufRead', {
   callback = function()
      vim.api.nvim_create_autocmd('BufWinEnter', {
         once = true,
         command = 'normal! zx',
      })
   end
})
