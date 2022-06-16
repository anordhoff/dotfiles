--Set up orgmode
require('orgmode').setup_ts_grammar()

require('orgmode').setup {
  org_agenda_files = { '~/Nextcloud/org/*' },
  org_default_notes_file = '~/Nextcloud/org/refile.org',
}

vim.keymap.set('n', '<leader>os', function()
  require('telescope.builtin').live_grep { search_dirs = { '$HOME/Nextcloud/org' } }
end)

vim.keymap.set('n', '<leader>of', function()
  require('telescope.builtin').find_files { search_dirs = { '$HOME/Nextcloud/org' } }
end)

--Clear white space on empty lines and end of line
vim.keymap.set(
  'n',
  '<F6>',
  [[:let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>]],
  { silent = true }
)
