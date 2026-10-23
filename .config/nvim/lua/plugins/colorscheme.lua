return {
  -- Kanagawa Dragon: Dark, Earthy & Elegant Theme
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      compile = false,
      undercurl = true,
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = false,
      dimInactive = false,
      terminalColors = true,
      theme = "dragon",
      background = {
        dark = "dragon",
        light = "lotus",
      },
    },
    config = function(_, opts)
      require("kanagawa").setup(opts)
      vim.cmd.colorscheme("kanagawa-dragon")

      -- AI Autocomplete highlights (Kanagawa Dragon blue)
      vim.api.nvim_set_hl(0, "CmpItemKindSupermaven", { fg = "#8ba4b0", bold = true })
      vim.api.nvim_set_hl(0, "SupermavenSuggestion", { fg = "#8ba4b0", italic = true })
    end,
  },

  -- Tokyo Night (Alternative Theme)
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      style = "night",
      transparent = false,
    },
  },

  -- Catppuccin Mocha (Alternative Theme)
  {
    "catppuccin/nvim",
    name = "catppuccin",
    tag = "v1.9.0",
    lazy = true,
    opts = {
      flavour = "mocha",
      transparent_background = true,
      term_colors = true,
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = { "italic" },
        functions = { "bold" },
        keywords = { "italic" },
        strings = {},
        variables = {},
        numbers = {},
        booleans = { "bold" },
        properties = {},
        types = { "italic" },
        operators = {},
      },
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        which_key = true,
        telescope = { enabled = true },
        bufferline = true,
        mason = true,
        rainbow_delimiters = true,
        indent_blankline = {
          enabled = true,
          scope_color = "mauve",
          colored_indent_levels = true,
        },
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
    end,
  },

  -- Sonokai (Alternative Retro Theme)
  {
    "sainnhe/sonokai",
    lazy = true,
  },
}
