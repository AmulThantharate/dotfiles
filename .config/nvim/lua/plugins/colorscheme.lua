return {
  -- Tokyo Night (Night): Clean, Cyber Dark & Transparent Theme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight-night")

      -- Enforce 100% transparent backgrounds for window layout elements
      local function make_transparent()
        local transparent_groups = {
          "Normal",
          "NormalNC",
          "SignColumn",
          "LineNr",
          "CursorLineNr",
          "FoldColumn",
          "EndOfBuffer",
          "NormalFloat",
          "FloatBorder",
          "NvimTreeNormal",
          "NvimTreeNormalNC",
          "NvimTreeEndOfBuffer",
          "NvimTreeWinSeparator",
          "TelescopeNormal",
          "TelescopeBorder",
          "TelescopePromptNormal",
          "TelescopePromptBorder",
          "TelescopeResultsNormal",
          "TelescopeResultsBorder",
          "TelescopePreviewNormal",
          "TelescopePreviewBorder",
        }
        for _, group in ipairs(transparent_groups) do
          vim.api.nvim_set_hl(0, group, { bg = "none", ctermbg = "none" })
        end

        -- AI Autocomplete highlights (Tokyo Night blue)
        vim.api.nvim_set_hl(0, "CmpItemKindSupermaven", { fg = "#7aa2f7", bold = true })
        vim.api.nvim_set_hl(0, "SupermavenSuggestion", { fg = "#7aa2f7", italic = true })
      end

      make_transparent()
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = make_transparent,
      })
    end,
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
