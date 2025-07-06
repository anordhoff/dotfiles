vim.loader.enable()

if vim.api.nvim_get_option_value('loadplugins', {}) then
  require('config.harpoon')
  require('config.leap')
  require('config.lspconfig')
  require('config.lint')
  require('config.spooky')
  require('config.telescope')
  require('config.textobjects')
  require('config.treesitter')

  vim.lsp.enable({ 'bashls', 'jsonls', 'marksman', 'pyright', 'vimls' })


  ----------------------------------------
  -- lazyload copilot-chat
  ----------------------------------------

  local copilot_chat
  local loaded_copilot_chat

  local function load_copilot_chat()
    if not loaded_copilot_chat then
      vim.cmd('packadd copilot-chat')
      copilot_chat = require('config.copilot-chat')
      loaded_copilot_chat = true
    end
  end

  -- keymaps and commands
  vim.keymap.set({'n', 'v'}, '<m-c>', function() load_copilot_chat(); copilot_chat.toggle() end, {})
  vim.keymap.set({'n', 'v'}, '<leader>c', function() load_copilot_chat(); return ':CopilotChat' end, { expr = true })


  ----------------------------------------
  -- lazyload indent-blankline
  ----------------------------------------

  local indent_blankline
  local indent_blankline_conf
  local loaded_indent_blankline

  local function load_indent_blankline()
    if not loaded_indent_blankline then
      vim.cmd('packadd indent-blankline')
      indent_blankline = require('config.indent-blankline')
      indent_blankline_conf = require('ibl.config')
      loaded_indent_blankline = true
    end
  end
  -- keymaps (follows vim-unimpaired pattern - yog[uidelines])
  vim.keymap.set('n', '[og', function() load_indent_blankline(); indent_blankline.update { enabled = true } end, {})
  vim.keymap.set('n', ']og', function() load_indent_blankline(); indent_blankline.update { enabled = false } end, {})
  vim.keymap.set('n', 'yog', function() load_indent_blankline(); indent_blankline.update { enabled = not indent_blankline_conf.get_config(-1).enabled } end, {})


  ----------------------------------------
  -- lazyload lint
  ----------------------------------------

  -- local loaded_lint
  --
  -- local function load_lint()
  --   if not loaded_lint then
  --     vim.cmd('packadd lint')
  --     require('config.lint')
  --     loaded_lint = true
  --   end
  -- end
  --
  -- vim.api.nvim_create_autocmd({ 'BufWinEnter', }, {
  --   group = vim.api.nvim_create_augroup('load_lint_config', { clear = true }),
  --   callback = function()
  --     load_lint()
  --   end,
  --   pattern = '*.go',
  -- })

end
