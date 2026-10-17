return {
  -- Sonokai: Andromeda style with transparent background (JazzyGrim primary theme)
  {
    "sainnhe/sonokai",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.sonokai_transparent_background = "1"
      vim.g.sonokai_enable_italic = "1"
      vim.g.sonokai_style = "andromeda"
      vim.cmd.colorscheme("sonokai")

      -- Enforce 100% transparent backgrounds across all UI elements
      local function make_transparent()
        local transparent_groups = {
          "Normal",
          "NormalNC",
          "Comment",
          "Constant",
          "Special",
          "Identifier",
          "Statement",
          "PreProc",
          "Type",
          "Underlined",
          "Todo",
          "String",
          "Function",
          "Conditional",
          "Repeat",
          "Operator",
          "Structure",
          "LineNr",
          "NonText",
          "SignColumn",
          "CursorLineNr",
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
      end

      make_transparent()
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = make_transparent,
      })
    end,
  },

  -- Tokyo Night (Alternative Transparent Theme)
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

  -- Catppuccin (Alternative Transparent Theme)
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    opts = {
      flavour = "mocha",
      transparent_background = true,
    },
  },
}
