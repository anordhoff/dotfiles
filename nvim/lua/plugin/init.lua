vim.loader.enable()

if vim.api.nvim_get_option_value('loadplugins', {}) then

  -- enable lua plugins
  require('plugin.harpoon')
  -- require('plugin.leap')    -- TODO: codeberg is blocked at work
  require('plugin.lspconfig')
  require('plugin.telescope')
  require('plugin.textobjects')
  require('plugin.treesitter')

  -- enable lsp servers
  vim.lsp.enable({ 'bashls', 'gopls', 'jsonls', 'lua_ls', 'marksman', 'pyright', 'vimls', 'yamlls' })


  ----------------------------------------
  -- lazyload indent-blankline
  ----------------------------------------

  local indent_blankline
  local indent_blankline_conf
  local loaded_indent_blankline

  local function load_indent_blankline()
    if not loaded_indent_blankline then
      vim.cmd('packadd indent-blankline')
      indent_blankline = require('plugin.indent-blankline')
      indent_blankline_conf = require('ibl.config')
      loaded_indent_blankline = true
    end
  end

  -- keymaps (follows vim-unimpaired pattern - yog[uidelines])
  vim.keymap.set('n', '[og', function() load_indent_blankline(); indent_blankline.update { enabled = true } end, {})
  vim.keymap.set('n', ']og', function() load_indent_blankline(); indent_blankline.update { enabled = false } end, {})
  vim.keymap.set('n', 'yog', function() load_indent_blankline(); indent_blankline.update { enabled = not indent_blankline_conf.get_config(-1).enabled } end, {})

end
