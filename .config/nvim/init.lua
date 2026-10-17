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

require("config.options")
require("config.lazy")
require("config.autocmds")
require("config.keymaps")
