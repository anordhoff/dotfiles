-- schema files
local schema_files = {
  cloudformation = 'https://raw.githubusercontent.com/aws-cloudformation/cfn-lint-visual-studio-code/main/server/schema/base.schema.json',
  kustomize = 'http://json.schemastore.org/kustomization',
  argocd_application = 'https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/application_v1alpha1.json',
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
    '/*-deployment.{yml,yaml}',
    '/*-deployments.{yml,yaml}',
    '/*-service.{yml,yaml}',
    '/*-services.{yml,yaml}',
    '/*-operator.{yml,yaml}',
    '/*-operators.{yml,yaml}',
    '/clusterrole.{yml,yaml}',
    '/clusterroles.{yml,yaml}',
    '/cluster-role.{yml,yaml}',
    '/cluster-roles.{yml,yaml}',
    '/clusterrolebinding.{yml,yaml}',
    '/clusterrolebindings.{yml,yaml}',
    '/cluster-rolebinding.{yml,yaml}',
    '/cluster-rolebindings.{yml,yaml}',
    '/cluster-role-binding.{yml,yaml}',
    '/cluster-role-bindings.{yml,yaml}',
    '/configmap.{yml,yaml}',
    '/configmaps.{yml,yaml}',
    '/config-map.{yml,yaml}',
    '/config-maps.{yml,yaml}',
    '/cronjob.{yml,yaml}',
    '/cronjobs.{yml,yaml}',
    '/cron-job.{yml,yaml}',
    '/cron-jobs.{yml,yaml}',
    '/daemonset.{yml,yaml}',
    '/daemonsets.{yml,yaml}',
    '/daemon-set.{yml,yaml}',
    '/daemon-sets.{yml,yaml}',
    '/deployment-*.{yml,yaml}',
    '/deployments-*.{yml,yaml}',
    '/deployment.{yml,yaml}',
    '/deployments.{yml,yaml}',
    '/hpa.{yml,yaml}',
    '/hpas.{yml,yaml}',
    '/ingress.{yml,yaml}',
    '/ingresses.{yml,yaml}',
    '/job.{yml,yaml}',
    '/jobs.{yml,yaml}',
    '/namespace.{yml,yaml}',
    '/namespaces.{yml,yaml}',
    '/operator.{yml,yaml}',
    '/operators.{yml,yaml}',
    '/pod.{yml,yaml}',
    '/pods.{yml,yaml}',
    '/pvc.{yml,yaml}',
    '/pvcs.{yml,yaml}',
    '/rbac.{yml,yaml}',
    '/rbacs.{yml,yaml}',
    '/replicaset.{yml,yaml}',
    '/replicasets.{yml,yaml}',
    '/replica-set.{yml,yaml}',
    '/replica-sets.{yml,yaml}',
    '/role.{yml,yaml}',
    '/roles.{yml,yaml}',
    '/rolebinding.{yml,yaml}',
    '/rolebindings.{yml,yaml}',
    '/role-binding.{yml,yaml}',
    '/role-bindings.{yml,yaml}',
    '/sa.{yml,yaml}',
    '/sas.{yml,yaml}',
    '/secret.{yml,yaml}',
    '/secrets.{yml,yaml}',
    '/service.{yml,yaml}',
    '/services.{yml,yaml}',
    '/service-*.{yml,yaml}',
    '/services-*.{yml,yaml}',
    '/serviceaccount.{yml,yaml}',
    '/serviceaccounts.{yml,yaml}',
    '/service-account.{yml,yaml}',
    '/service-accounts.{yml,yaml}',
    '/statefulset.{yml,yaml}',
    '/statefulsets.{yml,yaml}',
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

local schemas = {
  [schema_files.cloudformation] = patterns['cloudformation'],
  [schema_files.kustomize] = patterns['kustomize'],
  [schema_files.argocd_application] = patterns['argocd_application'],
  [schema_files.kubernetes] = patterns['kubernetes'],
}

local ok, jobfiles = pcall(require, 'jobfiles.lspconfig')
if ok then
  schemas[jobfiles.yamlls.job1.schema_file] = jobfiles.yamlls.job1.patterns
  schemas[jobfiles.yamlls.job2.schema_file] = jobfiles.yamlls.job2.patterns

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
end

-- filter out specific diagnostic messages
local show_yamlls_diagnostic
local function my_custom_diagnostic_handler(_, result, ctx)
  result.diagnostics = vim.tbl_filter(function(diagnostic)
    return show_yamlls_diagnostic(diagnostic)
  end, result.diagnostics)
  vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx)
end
vim.lsp.handlers['textDocument/publishDiagnostics'] = my_custom_diagnostic_handler

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
return {
  settings = {
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
      schemas = schemas,
      customTags = custom_tags,
    },
  },
}
