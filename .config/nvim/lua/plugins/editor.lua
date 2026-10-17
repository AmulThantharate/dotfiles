return {
  -- Telescope Fuzzy Finder
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      "nvim-telescope/telescope-file-browser.nvim",
    },
    opts = {
      defaults = {
        prompt_prefix = "  ",
        selection_caret = "❯ ",
        path_display = { "truncate" },
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
          },
          width = 0.88,
          height = 0.82,
        },
        file_ignore_patterns = {
          "node_modules",
          "%.git/",
          "%.terraform/",
          "target/",
          "dist/",
          "build/",
        },
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      pcall(telescope.load_extension, "fzf")
      pcall(telescope.load_extension, "file_browser")
    end,
  },

  -- Git signs in gutter
  {
    "lewis6991/gitsigns.nvim",
    commit = "2c2463dbd82eddd7dbab881c3a62cfbfbe3c67ae",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
    },
  },

  -- Commenting (VS Code Ctrl+/ support)
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },
}
