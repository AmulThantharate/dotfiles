return {
  -- SchemaStore for Kubernetes, GitHub Actions, Helm & Compose schemas
  { "b0o/SchemaStore.nvim", lazy = true },

  -- Mason: Package Manager for LSP, Linters & Formatters
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    opts = {
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },

  -- Mason LSP Config Bridge
  {
    "williamboman/mason-lspconfig.nvim",
    commit = "21d33d69a81f6351e5a5f49078b2e4f0075c8e73",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "terraformls",
        "dockerls",
        "docker_compose_language_service",
        "yamlls",
        "ansiblels",
        "bashls",
        "pyright",
        "jsonls",
        "lua_ls",
      },
      automatic_installation = true,
    },
  },

  -- LSP Configuration for Cloud DevOps Stack
  {
    "neovim/nvim-lspconfig",
    commit = "d5b6d4366dfd7a1071b930defd365e6d0be258de",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "b0o/SchemaStore.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local cmp_lsp = require("cmp_nvim_lsp")
      local capabilities = cmp_lsp.default_capabilities()

      local on_attach = function(_, bufnr)
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
        end
        map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
        map("n", "gr", vim.lsp.buf.references, "Find References")
        map("n", "gI", vim.lsp.buf.implementation, "Go to Implementation")
        map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
        map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
        map("n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
        map("n", "[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
        map("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")
      end

      -- 1. Terraform / OpenTofu
      lspconfig.terraformls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = { "terraform", "terraform-vars", "tf", "hcl" },
      })

      -- 2. Docker & Dockerfile
      lspconfig.dockerls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- 3. Docker Compose
      lspconfig.docker_compose_language_service.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = { "yaml.docker-compose" },
      })

      -- 4. YAML (Kubernetes, Helm, GitHub Actions)
      lspconfig.yamlls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          yaml = {
            schemaStore = {
              enable = false,
              url = "",
            },
            schemas = require("schemastore").yaml.schemas(),
            validate = true,
            format = { enable = true },
          },
        },
      })

      -- 5. Ansible
      lspconfig.ansiblels.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = { "yaml.ansible" },
      })

      -- 6. Bash / Shell scripting
      lspconfig.bashls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = { "sh", "bash" },
      })

      -- 7. Python (Automation & Cloud scripts)
      lspconfig.pyright.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- 8. JSON / CloudFormation / Policy documents
      lspconfig.jsonls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      })

      -- 9. Lua (Neovim configuration)
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      })
    end,
  },

  -- Treesitter: Highlighting for Cloud DevOps Languages
  {
    "nvim-treesitter/nvim-treesitter",
    commit = "63260da18bf273c76b8e2ea0db84eb901cab49ce",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      ensure_installed = {
        "terraform",
        "hcl",
        "dockerfile",
        "yaml",
        "json",
        "bash",
        "python",
        "groovy",
        "markdown",
        "markdown_inline",
        "lua",
        "vim",
        "regex",
        "gitignore",
        "sql",
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  -- Code Formatting
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        sh = { "shfmt" },
        bash = { "shfmt" },
        terraform = { "terraform_fmt" },
        tf = { "terraform_fmt" },
        yaml = { "prettier" },
        json = { "prettier" },
      },
      format_on_save = {
        timeout_ms = 800,
        lsp_fallback = true,
      },
    },
  },

  -- Auto-completion Engine & Snippets
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
      },
      "rafamadriz/friendly-snippets",
      "windwp/nvim-autopairs",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()

      -- Autopairs integration
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local autopairs = require("nvim-autopairs")
      autopairs.setup({ fast_wrap = {} })
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },
}
