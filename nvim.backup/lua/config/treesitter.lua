-- install parsers using git instead of curl to prevent proxy issues
require('nvim-treesitter.install').prefer_git = true

-- TODO: [[ and ]] to move between functions (do it better than stock vim)

require('nvim-treesitter.configs').setup {

  -- Install parsers to XDG_DATA_HOME, rather than treesitter package
  parser_install_dir = "~/.local/share/nvim/site",

  -- A list of parser names, or "all"
  ensure_installed = all,

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = false,

  -- List of parsers to ignore installing (for "all")
  ignore_install = {},

  highlight = {
    enable = false,
  },
  incremental_selection = {
    enable = false,
  },
  indent = {
    enable = false,
  },

  -- nvim-treesitter-textobjects
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      include_surrounding_whitespace = false,
      keymaps = {
        ['if'] = '@function.inner',
        ['af'] = '@function.outer',
        ['ic'] = '@class.inner',
        ['ac'] = '@class.outer',
        ['iC'] = '@conditional.inner',
        ['aC'] = '@conditional.outer',
        ['iL'] = '@loop.inner',
        ['aL'] = '@loop.outer',
      },
      selection_modes = {},
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>an'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>al'] = '@parameter.inner',
      },
    },
    move = {
      enable = false,
    },
  },
}
