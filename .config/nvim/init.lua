-- ====================================================================
--  Cloud DevOps Neovim IDE
--  Inspired by JazzyGrim/dotfiles & configured for Cloud DevOps
--  VS Code Keybindings + Transparent Aesthetic + Full DevOps Toolchain
-- ====================================================================

if vim.loader then
  vim.loader.enable()
end

-- Neovim 0.9.x backwards compatibility polyfills
if not vim.fs.joinpath then
  vim.fs.joinpath = function(...)
    return (table.concat({ ... }, "/"):gsub("//+", "/"))
  end
end

if not vim.lsp.enable then
  vim.lsp.enable = function(...) end
end

if not vim.iter then
  vim.iter = function(t)
    local items = t or {}
    local M = {}
    function M:filter(fn)
      local res = {}
      for _, v in pairs(items) do
        if fn(v) then table.insert(res, v) end
      end
      return vim.iter(res)
    end
    function M:map(fn)
      local res = {}
      for _, v in pairs(items) do
        table.insert(res, fn(v))
      end
      return vim.iter(res)
    end
    function M:totable()
      return items
    end
    return setmetatable(M, { __index = items })
  end
end

require("config.options")
require("config.lazy")
require("config.autocmds")
require("config.keymaps")
