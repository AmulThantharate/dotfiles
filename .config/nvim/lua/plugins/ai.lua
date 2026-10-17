return {
  -- Supermaven: Ultra-fast AI Autocomplete for all languages (Free tier out-of-the-box)
  {
    "supermaven-inc/supermaven-nvim",
    event = "InsertEnter",
    opts = {
      keymaps = {
        accept_suggestion = "<Tab>",
        clear_suggestion = "<C-]>",
        accept_word = "<C-j>",
      },
      ignore_filetypes = {},
      color = {
        suggestion_color = "#89b4fa",
        cterm = 244,
      },
      log_level = "info",
      disable_inline_completion = false,
      disable_keymaps = false,
    },
  },
}
