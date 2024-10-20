vim.loader.enable()

if vim.api.nvim_get_option_value('loadplugins', {}) then
  require('config.leap')
  require('config.lint')
  require('config.lspconfig')
  require('config.telescope')
  require('config.treesitter')

  -- lazyload copilot-chat
  local function load_copilot_chat(command, args)
    local copilot_chat
    local loaded_copilot_chat
    if not loaded_copilot_chat then
      vim.cmd('packadd copilot-chat')
      copilot_chat = require('config.copilot-chat')
      loaded_copilot_chat = true
    end
    if command == 'open' then
      copilot_chat.ask(table.concat(args, ' '))
    elseif command == 'toggle' then
      copilot_chat.toggle()
    end
  end
  -- keymaps and commands
  vim.api.nvim_create_user_command('CopilotChat', function(args) load_copilot_chat('open', args.fargs) end, { nargs = '*' })
  vim.keymap.set('n', '<leader>c<space>', function() return ':CopilotChat ' end, { expr = true })
  vim.keymap.set('n', '<leader>cc', function() load_copilot_chat('toggle') end, {})

  -- lazyload indent-blankline
  local function load_indent_blankline(command)
    local indent_blankline
    local indent_blankline_conf
    local loaded_indent_blankline
    if not loaded_indent_blankline then
      vim.cmd('packadd indent-blankline')
      indent_blankline = require('config.indent-blankline')
      indent_blankline_conf = require('ibl.config')
      loaded_indent_blankline = true
    end
    if command == 'enable' then
      indent_blankline.update { enabled = true }
    elseif command == 'disable' then
      indent_blankline.update { enabled = false }
    elseif command == 'toggle' then
      indent_blankline.update { enabled = not indent_blankline_conf.get_config(-1).enabled }
    end
  end
  -- keymaps (follows vim-unimpaired pattern - yog[uidelines])
  vim.keymap.set('n', '[og', function() load_indent_blankline('enable') end, {})
  vim.keymap.set('n', ']og', function() load_indent_blankline('disable') end, {})
  vim.keymap.set('n', 'yog', function() load_indent_blankline('toggle') end, {})
end
