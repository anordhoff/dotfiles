local lspconfig = require('lspconfig')
local util = require('lspconfig.util')

-- border style
-- add a border to floating windows
-- add a border to :LspInfo window
vim.o.winborder = 'single'

-- customize how diagnostics are displayed
vim.diagnostic.config({
  float = { source = true },
  severity_sort = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  virtual_text = { current_line = true },
})

-- highlight line numbers when there are diagnostics to display
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "",
    },
    linehl = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
      [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
    },
  },
})

-- print client information
-- filter out specific diagnostic messages
local show_yamlls_diagnostic
local function my_custom_diagnostic_handler(_, result, ctx)
  result.diagnostics = vim.tbl_filter(function(diagnostic)
    return show_yamlls_diagnostic(diagnostic)
  end, result.diagnostic)
  vim.lsp.diagnostic.on_publish_diagnostic(_, result, ctx)
end
vim.lsp.handlers['textDocument/publishDiagnostic'] = my_custom_diagnostic_handler

-- global mappings.
-- see `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { silent = true }
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<leader>qd', vim.diagnostic.setqflist, opts)
vim.keymap.set('n', '<leader>ld', vim.diagnostic.setloclist, opts)

-- use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lspconfig_config', { clear = true }),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    -- don't setup keymaps if the only client attached is copilot
    if client ~= nil and client.name == "GitHub Copilot" then
      return
    end

    -- enable autocompletion
    if client ~= nil and client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end

    -- keymaps
    local bufopts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, bufopts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>F', function() vim.lsp.buf.format { async = true } end, bufopts)

    -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    -- vim.keymap.set('n', 'grn', vim.lsp.buf.rename, bufopts)
    -- vim.keymap.set('n', 'grr', vim.lsp.buf.references, bufopts)
    -- vim.keymap.set('n', 'gri', vim.lsp.buf.implementation, bufopts)
    -- vim.keymap.set({ 'n', 'v' }, 'gra', vim.lsp.buf.code_actions, bufopts)
    -- vim.keymap.set('n', 'gO', vim.lsp.buf.document_symbol, bufopts)
    -- vim.keymap.set('i', '<c-s>', vim.lsp.buf.signature_help, bufopts)
  end,
})

-- use a loop to call 'setup' on multiple servers

----------------------------------------
-- gopls
----------------------------------------

-- setup configuration
lspconfig.gopls.setup {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  root_dir = function(fname)
    local primary = util.root_pattern('go.work', 'go.mod')(fname)
    local fallback = vim.fs.dirname(vim.fs.find('.git', { path = fname, upward = true })[1])
    return primary or fallback
  end,
  settings = {
    gopls = {
      analyses = {
        fieldalignment = false,
        nilness = true,
        shadow = false,
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

-- NOTE: imports appear to save after saving changes, but if at some point they don't, 
-- take a look here: https://github.com/neovim/neovim/issues/24168#issuecomment-2601156286
-- format code and organize imports when writing the buffer
-- organize impor on save
-- TODO(bug): save after importing (https://github.com/neovim/neovim/issues/24168)
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup('lspconfig_golang_config', { clear = true }),
  callback = function()
    vim.lsp.buf.format { async = true }
    vim.lsp.buf.code_action { context = { diagnostic = {}, only = { 'source.organizeImports' } }, apply = true }
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
-- marksman
----------------------------------------

-- disable semantic highlighting for markdown
-- lspconfig.marksman.setup {
--   on_attach = function(client, _)
--     client.server_capabilities.semanticTokensProvider = nil
--   end,
-- }


----------------------------------------
-- yamlls
----------------------------------------

local jobfiles = require('jobfiles.lspconfig')

-- schemas
local schemas = {
  cloudformation = 'https://raw.githubusercontent.com/aws-cloudformation/cfn-lint-visual-studio-code/main/server/schema/base.schema.json',
  kustomize = 'http://json.schemastore.org/kustomization',
  argocd_applications = 'https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/application_v1alpha1.json',
  kubernetes = 'https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/master-standalone-strict/all.json',
}

-- schema patterns
local patterns = {
  cloudformation = {
    '**/{cfn,cloudformation,aws}/**/*.{yml,yaml}',
    '**/{cfn,cloudformation,template}.{yml,yaml}',
  },
  kustomize = {
    '/kustomization.{yml,yaml}',
  },
  argocd_application = {
    '/application.{yml,yaml}',
  },
  kubernetes = {
    '**/{kubernetes,kube,k8s,kustomize,base,kind}/**/*{!kustomization,!application}.{yml,yaml}',
    '*-deployment.{yml,yaml}',
    '*-deployments.{yml,yaml}',
    '*-service.{yml,yaml}',
    '*-services.{yml,yaml}',
    'clusterrole.{yml,yaml}',
    'clusterroles.{yml,yaml}',
    'cluster-role.{yml,yaml}',
    'cluster-roles.{yml,yaml}',
    'clusterrolebinding.{yml,yaml}',
    'clusterrolebindings.{yml,yaml}',
    'cluster-rolebinding.{yml,yaml}',
    'cluster-rolebindings.{yml,yaml}',
    'cluster-role-binding.{yml,yaml}',
    'cluster-role-bindings.{yml,yaml}',
    'configmap.{yml,yaml}',
    'configmaps.{yml,yaml}',
    'config-map.{yml,yaml}',
    'config-maps.{yml,yaml}',
    'cronjob.{yml,yaml}',
    'cronjobs.{yml,yaml}',
    'cron-job.{yml,yaml}',
    'cron-jobs.{yml,yaml}',
    'daemonset.{yml,yaml}',
    'daemonsets.{yml,yaml}',
    'daemon-set.{yml,yaml}',
    'daemon-sets.{yml,yaml}',
    'deployment-*.{yml,yaml}',
    'deployments-*.{yml,yaml}',
    'deployment.{yml,yaml}',
    'deployments.{yml,yaml}',
    'hpa.{yml,yaml}',
    'hpas.{yml,yaml}',
    'ingress.{yml,yaml}',
    'ingresss.{yml,yaml}',
    'job.{yml,yaml}',
    'jobs.{yml,yaml}',
    'namespace.{yml,yaml}',
    'namespaces.{yml,yaml}',
    'pod.{yml,yaml}',
    'pods.{yml,yaml}',
    'pvc.{yml,yaml}',
    'pvcs.{yml,yaml}',
    'rbac.{yml,yaml}',
    'rbacs.{yml,yaml}',
    'replicaset.{yml,yaml}',
    'replicasets.{yml,yaml}',
    'replica-set.{yml,yaml}',
    'replica-sets.{yml,yaml}',
    'role.{yml,yaml}',
    'roles.{yml,yaml}',
    'rolebinding.{yml,yaml}',
    'rolebindings.{yml,yaml}',
    'role-binding.{yml,yaml}',
    'role-bindings.{yml,yaml}',
    'sa.{yml,yaml}',
    'sas.{yml,yaml}',
    'secret.{yml,yaml}',
    'secrets.{yml,yaml}',
    'service-*.{yml,yaml}',
    'services-*.{yml,yaml}',
    'serviceaccount.{yml,yaml}',
    'serviceaccounts.{yml,yaml}',
    'service-account.{yml,yaml}',
    'service-accounts.{yml,yaml}',
    'statefulset.{yml,yaml}',
    'statefulsets.{yml,yaml}',
  },
}

-- cloudformation custom tags
local custom_tags = {
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
}

-- read job specific schema patterns from jobfiles. Each schema should have a
-- newline separated list of glob patterns in its own file, where the name of
-- the file matches the name of the schema (.txt). Patterns are appended to the
-- nested table of the same under the 'patterns' table
for schema, _ in pairs(patterns) do
  local file = io.open(jobfiles.yamlls.path_to_schemas .. schema .. '.txt', 'r')
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

-- filter out the 'matches multiple schemas' error
function show_yamlls_diagnostic(diagnostic)
  local message = 'Matches multiple schemas when only one must validate.'
  local source = 'yaml-schema: https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/master-standalone-strict/all.json'
  if diagnostic.message == message and diagnostic.source == source then
    return false
  end
  return true
end

-- setup configuration
lspconfig.yamlls.setup {
  settings = {
    -- http = {
    --   proxy = jobfiles.yamlls.proxy,
    --   proxyStrictSSL = false
    -- },
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
        [schemas.cloudformation] = patterns['cloudformation'],
        [schemas.kustomize] = patterns['kustomize'],
        [schemas.argocd_applications] = patterns['argocd_application'],
        [schemas.kubernetes] = patterns['kubernetes'],
        [jobfiles.yamlls.job1.schema] = jobfiles.yamlls.job1.patterns,
        [jobfiles.yamlls.job2.schema] = jobfiles.yamlls.job2.patterns,
        [jobfiles.yamlls.job3.schema] = jobfiles.yamlls.job3.patterns,
      },
      customTags = custom_tags,
    },
  },
}
