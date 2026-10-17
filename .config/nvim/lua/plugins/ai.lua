return {
  -- Supermaven: Ultra-fast AI Autocomplete for all languages (Free tier out-of-the-box)
  {
    "supermaven-inc/supermaven-nvim",
    event = "VeryLazy",
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
      log_level = "off",
      disable_inline_completion = false,
      disable_keymaps = false,
    },
    config = function(_, opts)
      require("supermaven-nvim").setup(opts)
      -- Direct fallback shortcut to guarantee accepting AI completion
      vim.keymap.set("i", "<C-a>", function()
        local suggestion = require("supermaven-nvim.completion_preview")
        if suggestion.has_suggestion() then
          suggestion.on_accept_suggestion()
        end
      end, { silent = true, desc = "Accept AI Completion" })
    end,
  },
}
