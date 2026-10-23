return {
  -- Kanagawa Dragon: Dark, Earthy & Elegant Transparent Theme
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
      transparent = true,
      dimInactive = false,
      terminalColors = true,
      theme = "dragon",
      background = {
        dark = "dragon",
        light = "lotus",
      },
      overrides = function(colors)
        local theme = colors.theme
        return {
          Normal = { bg = "none" },
          NormalNC = { bg = "none" },
          NormalFloat = { bg = "none" },
          FloatBorder = { bg = "none" },
          FloatTitle = { bg = "none" },
          SignColumn = { bg = "none" },
          LineNr = { bg = "none" },
          CursorLineNr = { bg = "none" },
          FoldColumn = { bg = "none" },
          EndOfBuffer = { bg = "none" },
          NvimTreeNormal = { bg = "none" },
          NvimTreeNormalNC = { bg = "none" },
          NvimTreeEndOfBuffer = { bg = "none" },
          NvimTreeWinSeparator = { bg = "none" },
          TelescopeNormal = { bg = "none" },
          TelescopeBorder = { bg = "none" },
          TelescopePromptNormal = { bg = "none" },
          TelescopePromptBorder = { bg = "none" },
          TelescopeResultsNormal = { bg = "none" },
          TelescopeResultsBorder = { bg = "none" },
          TelescopePreviewNormal = { bg = "none" },
          TelescopePreviewBorder = { bg = "none" },
        }
      end,
    },
    config = function(_, opts)
      require("kanagawa").setup(opts)
      vim.cmd.colorscheme("kanagawa-dragon")

      -- Enforce transparent backgrounds across all UI elements to match terminal transparency
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
          "FloatTitle",
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
          "WhichKeyFloat",
        }
        for _, group in ipairs(transparent_groups) do
          vim.api.nvim_set_hl(0, group, { bg = "none", ctermbg = "none" })
        end

        -- AI Autocomplete highlights (Kanagawa Dragon blue)
        vim.api.nvim_set_hl(0, "CmpItemKindSupermaven", { fg = "#8ba4b0", bold = true })
        vim.api.nvim_set_hl(0, "SupermavenSuggestion", { fg = "#8ba4b0", italic = true })
      end

      make_transparent()
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = make_transparent,
      })
    end,
  },

  -- Tokyo Night (Alternative Theme)
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      style = "night",
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
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
