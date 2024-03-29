require("rest-nvim").setup({
  client = "curl",
  env_file = ".env",
  env_pattern = "\\.env$",
  env_edit_command = "tabedit",
  encode_url = true,
  skip_ssl_verification = false,
  custom_dynamic_variables = {},
  logs = {
    level = "info",
    save = false,
  },
  result = {
    split = {
      horizontal = true,
      stay_in_current_window_after_split = true,
    },
  },
  highlight = {
    enable = false,
  },
  keybinds = {
    {
      "<leader>rr", ":Rest run<cr>", "Run request under the cursor",
    },
    {
      "<leader>rl", ":Rest run last<cr>", "Re-run latest request",
    },
  }
})
