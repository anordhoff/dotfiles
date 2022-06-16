require('telescope').setup {
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
      ".git/",
      "vendor/",
      "node_modules/",
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

require('telescope').load_extension('fzf')
