require('nvim-treesitter.configs').setup {

  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = all,

  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  -- List of parsers to ignore installing
  ignore_install = { 'phpdoc', 'tree-sitter-phpdoc' },

  highlight = {
    enable = false,
  },
  incremental_selection = {
    enable = false,
  },
  indent = {
    enable = false,
  },

  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['if'] = '@function.inner',
        ['af'] = '@function.outer',
        ['im'] = '@class.inner',
        ['am'] = '@class.outer',
        ['ic'] = '@conditional.inner',
        ['ac'] = '@conditional.outer',
        ['il'] = '@loop.inner',
        ['al'] = '@loop.outer',
      }
    },
    swap = {
      enable = true,
      swap_next = {
        ['gl'] = '@parameter.inner',
      },
      swap_previous = {
        ['gh'] = '@parameter.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = false,
      goto_next_start = {
        [']f'] = '@function.outer',
        [']m'] = '@class.outer',
      },
      goto_next_end = {
        [']F'] = '@function.outer',
        [']M'] = '@class.outer',
      },
      goto_previous_start = {
        ['[f'] = '@function.outer',
        ['[m'] = '@class.outer',
      },
      goto_previous_end = {
        ['[F'] = '@function.outer',
        ['[M'] = '@class.outer',
      },
    },
  },
}

-- install parsers using git instead of curl to prevent proxy issues
require('nvim-treesitter.install').prefer_git = true
