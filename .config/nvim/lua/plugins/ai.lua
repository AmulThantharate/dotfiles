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

      -- Debounce AI suggestions to prevent instant popups while actively typing
      -- Adjust DEBOUNCE_MS (e.g. 350ms - 450ms) to make completions faster or slower
      local DEBOUNCE_MS = 380
      local binary = require("supermaven-nvim.binary.binary_handler")
      local preview = require("supermaven-nvim.completion_preview")
      local orig_provide = binary.provide_inline_completion_items
      local debounce_timer = (vim.uv or vim.loop).new_timer()

      binary.provide_inline_completion_items = function(self, buffer, cursor, context)
        debounce_timer:stop()
        preview:dispose_inlay()
        debounce_timer:start(
          DEBOUNCE_MS,
          0,
          vim.schedule_wrap(function()
            local mode = vim.api.nvim_get_mode().mode
            if mode:sub(1, 1) == "i" then
              orig_provide(self, buffer, cursor, context)
            end
          end)
        )
      end

      -- Clean up timer and preview upon leaving insert mode
      vim.api.nvim_create_autocmd("InsertLeave", {
        callback = function()
          debounce_timer:stop()
          preview:dispose_inlay()
        end,
      })

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
