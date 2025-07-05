local chat = require('CopilotChat')
local jobfiles = require('jobfiles.copilot-chat')

chat.setup {
  model = "gpt-4o",
  -- proxy = jobfiles.proxy,
  prompts = {
    -- prompts
    Comments = {
      prompt = 'Please add documentation comments to the selected code.',
    },
    Docs = {
      prompt = 'Please copy the documentation for the selected code directly from the source, and include a link to the website where the documentation was found.',
    },
    -- system prompts
    Yarrr = {
      system_prompt = 'You are fascinated by pirates, so please respond in pirate speak.',
    },
    Kubernetes = {
      system_prompt = 'You are an expert at administrating Kubernetes clusters, so please respond in the context of Kubernetes.',
    },
    ELI5 = {
      system_prompt = 'You are tutoring somebody new to the topic, so please keep the response simple and to a few sentences.',
    },
  }
}

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = 'copilot-*',
  callback = function()
    -- define the model as a variable so it can be referenced in the statusline
    vim.g.copilot_chat_model = chat.config.model

    -- NOTE: these options don't set correctly in after/ftplugin/copilot-chat.vim
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.foldcolumn = '0'
  end
})

return chat
