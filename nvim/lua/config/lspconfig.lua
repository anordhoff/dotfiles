local lspconfig = require('lspconfig')
local util = require('lspconfig.util')
local windows = require('lspconfig.ui.windows')

-- border style
local border = 'single'

-- add a border to floating windows
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- add a border to :LspInfo window
windows.default_options.border = border

-- customize how diagnostics are displayed
vim.diagnostic.config({
  float = {
    source = "if_many",
  },
  severity_sort = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  virtual_text = false,
})

-- highlight line numbers when there are diagnostics to display
for _, diag in ipairs({ "Error", "Warn", "Info", "Hint" }) do
    vim.fn.sign_define("DiagnosticSign" .. diag, {
        text = "",
        texthl = "DiagnosticSign" .. diag,
        linehl = "",
        numhl = "DiagnosticSign" .. diag,
    })
end

-- print client information
vim.api.nvim_create_user_command(
  'LspInspect',
  function()
    print(vim.inspect(vim.lsp.get_clients()))
  end,
  {}
)

-- global mappings.
-- see `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { silent = true }
vim.keymap.set('n', '<leader>dd', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setqflist, opts)
vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, opts)

-- use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lspconfig', { clear = true }),
  callback = function(ev)
    -- enable synchronous completion
    vim.bo[ev.buf].omnifunc = 'v:lua.omnifunc_sync'

    -- keymaps
    local bufopts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('i', '<c-k>', function()
      if vim.fn.col('.') > vim.fn.strlen(vim.fn.getline('.')) then
        return vim.lsp.buf.signature_help() else
        return vim.cmd.normal('D') and vim.fn.cursor(vim.fn.line('.'), vim.fn.col('.') + 1) end
    end, bufopts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<leader>F', function()
      vim.lsp.buf.format { async = true }
    end, bufopts)
  end,
})

-- use a loop to call 'setup' on multiple servers
local servers = { 'bashls', 'jsonls', 'marksman', 'pyright', 'terraformls', 'vimls' }
for _, lsp in pairs(servers) do
  lspconfig[lsp].setup {}
end


----------------------------------------
-- gopls
----------------------------------------

-- setup configuration
lspconfig.gopls.setup {
  cmd = { 'gopls', '-remote=auto' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  root_dir = function(fname)
    local primary = util.root_pattern('go.work', 'go.mod')(fname)
    local fallback = util.find_git_ancestor(fname)
    return primary or fallback
  end,
  settings = {
    gopls = {
      analyses = {
        fieldalignment = false,
        nilness = true,
        shadow = true,
        unusedparams = true,
        unusedwrite = true,
        useany = true,
        unusedvariable = true,
      },
      linksInHover = false,
      staticcheck = true,
    },
  },
}

-- format code and organize imports when writing the buffer
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup('lspconfig_golang', { clear = true }),
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}
    -- buf_request_sync defaults to a 1000ms timeout. Depending on your
    -- machine and codebase, you may want longer. Add an additional
    -- argument after params if you find that you have to write the file
    -- twice for changes to be saved.
    -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    vim.lsp.buf.format({async = false})
  end,
  pattern = "*.go",
})


----------------------------------------
-- lua_ls
----------------------------------------

-- setup configuration
lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim', 'use' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
}


----------------------------------------
-- yamlls
----------------------------------------

local jobfiles = require('config.job')

-- get home dir for use in local filepaths
local home_dir = os.getenv('HOME') .. '/'

-- path to schemas
local cloudformation = 'https://raw.githubusercontent.com/aws-cloudformation/cfn-lint-visual-studio-code/main/server/schema/base.schema.json'
local kubernetes = 'https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/master-standalone-strict/all.json'

-- schema patterns
local patterns = {
  cloudformation = {
    '**/{cfn,cloudformation,aws}/**/*.{yml,yaml}',
    '**/{cfn,cloudformation,template}.{yml,yaml}',
  },
  kubernetes = {
    '**/{kubernetes,kube,k8s,kustomize,base,kind}/**/*.{yml,yaml}',
    '*-deployment.{yml,yaml}',
    '*-service.{yml,yaml}',
    'clusterrole.{yml,yaml}',
    'clusterrolebinding.{yml,yaml}',
    'configmap.{yml,yaml}',
    'cronjob.{yml,yaml}',
    'daemonset.{yml,yaml}',
    'deployment-*.{yml,yaml}',
    'deployment.{yml,yaml}',
    'hpa.{yml,yaml}',
    'ingress.{yml,yaml}',
    'job.{yml,yaml}',
    'namespace.{yml,yaml}',
    'pvc.{yml,yaml}',
    'rbac.{yml,yaml}',
    'replicaset.{yml,yaml}',
    'role.{yml,yaml}',
    'rolebinding.{yml,yaml}',
    'sa.{yml,yaml}',
    'secret.{yml,yaml}',
    'service-*.{yml,yaml}',
    'service-account.{yml,yaml}',
    'service.{yml,yaml}',
    'serviceaccount.{yml,yaml}',
    'serviceaccounts.{yml,yaml}',
    'statefulset.{yml,yaml}',
  },
  job1 = jobfiles.yamlls.job1.patterns,
  job2 = jobfiles.yamlls.job2.patterns,
  job3 = jobfiles.yamlls.job3.patterns,
}

-- read work specific schema patterns from jobfiles. Each schema should have a
-- newline separated list of glob patterns in its own file, where the name of
-- the file matches the name of the schema (.txt). Patterns are appended to the
-- nested table of the same under the 'patterns' table
local path_to_schemas = home_dir .. 'jobfiles/nvim/schemas/'
for schema, _ in pairs(patterns) do
  local file = io.open(path_to_schemas .. schema .. '.txt', 'r')
  if file ~= nil then
    while true do
      local line = file:read()
      if line == nil then
        break
      end
      table.insert(patterns[schema], line)
    end
    io.close(file)
  end
end

-- setup configuration
lspconfig.yamlls.setup {
  settings = {
    http = {
      proxy = jobfiles.yamlls.proxy,
      proxyStrictSSL = false
    },
    redhat = {
      telemetry = { enabled = false }
    },
    yaml = {
      format = {
        enable = true
      },
      validate = true,
      hover = true,
      completion = true,
      schemas = {
        [cloudformation] = patterns['cloudformation'],
        [kubernetes] = patterns['kubernetes'],
        [jobfiles.yamlls.job1.schema] = patterns['job1'],
        [jobfiles.yamlls.job2.schema] = patterns['job2'],
        [jobfiles.yamlls.job3.schema] = patterns['job3'],
      },
      customTags = {
        -- cloudformation custom tags
        '!And mapping',
        '!And scalar',
        '!And sequence',
        '!Base64 mapping',
        '!Base64 scalar',
        '!Base64 sequence',
        '!Cidr mapping',
        '!Cidr scalar',
        '!Cidr sequence',
        '!Equals mapping',
        '!Equals scalar',
        '!Equals sequence',
        '!FindInMap mappping',
        '!FindInMap scalar',
        '!FindInMap sequence',
        '!GetAtt mapping',
        '!GetAtt scalar',
        '!GetAtt sequence',
        '!GetAZs mapping',
        '!GetAZs scalar',
        '!GetAZs sequence',
        '!If mapping',
        '!If scalar',
        '!If sequence',
        '!ImportValue mapping',
        '!ImportValue scalar',
        '!ImportValue sequence',
        '!Join mapping',
        '!Join scalar',
        '!Join sequence',
        '!Not mapping',
        '!Not scalar',
        '!Not sequence',
        '!Or mapping',
        '!Or scalar',
        '!Or sequence',
        '!Ref mapping',
        '!Ref scalar',
        '!Ref sequence',
        '!Select mapping',
        '!Select scalar',
        '!Select sequence',
        '!Split mapping',
        '!Split scalar',
        '!Split sequence',
        '!Sub mapping',
        '!Sub scalar',
        '!Sub sequence',
      },
    },
  },
}


----------------------------------------
-- synchronous omnifunc
----------------------------------------

-- TODO: use synchronous omnifunc when merged:
--   https://github.com/neovim/neovim/issues/12390
--   https://github.com/neovim/neovim/pull/16225
--   https://github.com/neovim/neovim/pull/17218

-- synchronous omnifunc that supports completeopt=longest
function _G.omnifunc_sync(findstart, base)
  local pos = vim.api.nvim_win_get_cursor(0)
  local line = vim.api.nvim_get_current_line()

  if findstart == 1 then
    -- Cache state of cursor line and position due to the fact that it will
    -- change at the second call to this function (with `findstart = 0`). See:
    -- https://github.com/vim/vim/issues/8510.
    -- This is needed because request to LSP server is made on second call.
    -- If not done, server's completion mechanics will operate on different
    -- document and position.
    -- omnifunc_cache = {pos = pos, line = line}

    -- On first call return column of completion start
    local line_to_cursor = line:sub(1, pos[2])
    return vim.fn.match(line_to_cursor, '\\k*$')
  end

  -- Restore cursor line and position to the state of first call
  -- vim.api.nvim_set_current_line(omnifunc_cache.line)
  -- vim.api.nvim_win_set_cursor(0, omnifunc_cache.pos)

  -- Make request
  local bufnr = vim.api.nvim_get_current_buf()
  local params = vim.lsp.util.make_position_params()
  local result = vim.lsp.buf_request_sync(bufnr, 'textDocument/completion', params, 2000)
  if not result then return {} end

  -- Transform request answer to list of completion matches
  local items = {}
  for _, item in pairs(result) do
    if not item.err then
      -- NOTE: text_document_completion_list_to_complete_items() will be removed in 0.11
      -- local matches = vim.lsp.util.text_document_completion_list_to_complete_items(item.result, base)
      local matches = vim.lsp._completion._lsp_to_complete_items(item.result, base)
      vim.list_extend(items, matches)
    end
  end

  -- Restore back cursor line and position to the state of this call's start
  -- (avoids outcomes of Vim's internal line postprocessing)
  -- vim.api.nvim_set_current_line(line)
  -- vim.api.nvim_win_set_cursor(0, pos)

  return items
end
