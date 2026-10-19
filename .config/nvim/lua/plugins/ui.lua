return {
  -- Web Devicons
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    opts = { default = true },
  },

  -- NvimTree: Fast File Explorer (sidebar)
  {
    "nvim-tree/nvim-tree.lua",
    commit = "030defdb6522f5f716d8201d20ca1a2baa57ca66",
    cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile" },
    opts = {
      disable_netrw = true,
      hijack_netrw = true,
      hijack_cursor = true,
      sync_root_with_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = false,
      },
      view = {
        width = 30,
        side = "left",
        relativenumber = true,
      },
      renderer = {
        group_empty = true,
        highlight_git = true,
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
        },
      },
      filters = {
        dotfiles = false,
        custom = { "^.git$", "node_modules" },
      },
      actions = {
        open_file = {
          quit_on_open = false,
          resize_window = true,
        },
      },
    },
    config = function(_, opts)
      require("nvim-tree").setup(opts)
    end,
  },

  -- Bufferline: VS Code Style Tabs
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        mode = "buffers",
        always_show_bufferline = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        color_icons = true,
        separator_style = "thin",
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level)
          local icon = level:match("error") and " " or " "
          return " " .. icon .. count
        end,
        offsets = {
          {
            filetype = "NvimTree",
            text = "EXPLORER",
            text_align = "left",
            highlight = "Directory",
            separator = true,
          },
        },
      },
    },
  },

  -- Incline: Floating filename badge in top right (JazzyGrim signature UI)
  {
    "b0o/incline.nvim",
    event = "BufReadPre",
    priority = 1200,
    config = function()
      local helpers = require("incline.helpers")
      require("incline").setup({
        window = {
          padding = 0,
          margin = { horizontal = 0 },
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if filename == "" then
            filename = "[No Name]"
          end
          local devicons = require("nvim-web-devicons")
          local ft_icon, ft_color = devicons.get_icon_color(filename)
          local modified = vim.bo[props.buf].modified
          return {
            ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or "",
            " ",
            { filename, gui = modified and "bold,italic" or "bold" },
            " ",
            guibg = "#2d3139",
          }
        end,
      })
    end,
  },

  -- Color highlighter
  {
    "echasnovski/mini.hipatterns",
    event = "BufReadPre",
    opts = {},
  },

  -- Rainbow Bracket Pairs: VS Code style colorful bracket pair colorization
  {
    "HiPhish/rainbow-delimiters.nvim",
    submodules = false,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      -- Neovim 0.10+ iter_matches compatibility fix for multi-node captures
      local q_dummy = vim.treesitter.query.parse("lua", "(identifier) @id")
      local mt = getmetatable(q_dummy)
      local target = mt.__index or mt
      if target and target.iter_matches and not target._rainbow_patched then
        local orig_iter_matches = target.iter_matches
        target.iter_matches = function(self, node, source, start, stop, opts)
          opts = opts or {}
          if opts.all == nil then
            opts.all = true
          end
          return orig_iter_matches(self, node, source, start, stop, opts)
        end
        target._rainbow_patched = true
      end

      local rainbow_delimiters = require("rainbow-delimiters")

      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          vim = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-delimiters",
          groovy = "rainbow-delimiters",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      }

      -- Enable for any already-opened buffers
      for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(bufnr) and vim.bo[bufnr].buflisted then
          pcall(rainbow_delimiters.enable, bufnr)
        end
      end
    end,
  },

  -- Indent Guides: Rainbow Indent Guides with Active Scope Matching
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local highlight = {
        "RainbowDelimiterRed",
        "RainbowDelimiterYellow",
        "RainbowDelimiterBlue",
        "RainbowDelimiterOrange",
        "RainbowDelimiterGreen",
        "RainbowDelimiterViolet",
        "RainbowDelimiterCyan",
      }

      local hooks = require("ibl.hooks")

      -- Register highlight setup hook to ensure vibrant colors match Catppuccin Mocha
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = "#f38ba8" })
        vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = "#f9e2af" })
        vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = "#89b4fa" })
        vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = "#fab387" })
        vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = "#a6e3a1" })
        vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = "#cba6f7" })
        vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = "#94e2d5" })

        -- Also define standard Rainbow* aliases
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#f38ba8" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#f9e2af" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#89b4fa" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#fab387" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#a6e3a1" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#cba6f7" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#94e2d5" })
      end)

      -- Dynamically synchronize the active scope line color with enclosing rainbow delimiter
      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)

      require("ibl").setup({
        indent = {
          char = "│",
          highlight = highlight,
        },
        scope = {
          enabled = true,
          char = "│",
          highlight = highlight,
          show_start = false,
          show_end = false,
          injected_languages = true,
        },
      })
    end,
  },

  -- Lualine: Clean Terminal Statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        theme = "auto",
        globalstatus = true,
        component_separators = { left = "│", right = "│" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { { "mode", icon = "" } },
        lualine_b = {
          { "branch", icon = "" },
          { "diff", symbols = { added = " ", modified = " ", removed = " " } },
        },
        lualine_c = {
          { "filename", file_status = true, path = 1 },
        },
        lualine_x = {
          {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            symbols = { error = " ", warn = " ", info = " ", hint = " " },
          },
          "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },

  -- Which-Key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
  },
}
