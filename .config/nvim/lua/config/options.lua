local opt = vim.opt

-- Leader key configuration
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Encodings
vim.scriptencoding = "utf-8"
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

-- Appearance & True Colors
opt.termguicolors = true
opt.background = "dark"
opt.cursorline = true
opt.signcolumn = "yes"
opt.showmode = false
opt.number = true
opt.relativenumber = true
opt.pumheight = 10
opt.pumblend = 0
opt.winblend = 0
opt.completeopt = { "menu", "menuone", "noselect" }

-- Tabs & Indentation (DevOps Standard: 2 spaces)
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true
opt.breakindent = true
opt.wrap = false

-- Search Settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Window Splitting
opt.splitright = true
opt.splitbelow = true

-- Mouse and Clipboard (VS Code behavior)
opt.mouse = "a"
opt.clipboard = "unnamedplus"

-- File and Undo management
opt.undofile = true
opt.swapfile = false
opt.backup = false
opt.updatetime = 200
opt.timeoutlen = 300

-- Cursor behavior
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Format options
opt.formatoptions:append({ "r" })
