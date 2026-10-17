local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ====================================================================
-- 1. VS Code Style Keybindings
-- ====================================================================

-- File Save (Ctrl+s)
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- Quick Open / Find Files (Ctrl+p)
map("n", "<C-p>", function()
  require("telescope.builtin").find_files({ hidden = true, no_ignore = false })
end, { desc = "VS Code: Quick Open File" })

-- Command Palette (Ctrl+Shift+P / Ctrl+P)
map("n", "<C-S-p>", "<cmd>Telescope commands<cr>", { desc = "VS Code: Command Palette" })
map("n", "<C-S-P>", "<cmd>Telescope commands<cr>", { desc = "VS Code: Command Palette" })

-- Toggle Sidebar / File Explorer (Ctrl+b)
map("n", "<C-b>", "<cmd>NvimTreeToggle<cr>", { desc = "VS Code: Toggle Primary Sidebar" })

-- Find in current buffer (Ctrl+f)
map("n", "<C-f>", function()
  require("telescope.builtin").current_buffer_fuzzy_find()
end, { desc = "VS Code: Find in file" })

-- Find in all project files / Live Grep (Ctrl+Shift+F)
map("n", "<C-S-f>", function()
  require("telescope.builtin").live_grep()
end, { desc = "VS Code: Find in Files (Live Grep)" })

-- Toggle Comment (Ctrl+/ and Ctrl+_)
map({ "n", "v" }, "<C-_>", "gcc", { remap = true, desc = "VS Code: Toggle line comment" })
map({ "n", "v" }, "<C-/>", "gcc", { remap = true, desc = "VS Code: Toggle line comment" })

-- Move Line Up / Down (Alt + Up / Down & Alt + k / j)
map("n", "<A-Down>", "<cmd>m .+1<cr>==", { desc = "VS Code: Move Line Down" })
map("n", "<A-Up>", "<cmd>m .-2<cr>==", { desc = "VS Code: Move Line Up" })
map("i", "<A-Down>", "<esc><cmd>m .+1<cr>==gi", { desc = "VS Code: Move Line Down" })
map("i", "<A-Up>", "<esc><cmd>m .-2<cr>==gi", { desc = "VS Code: Move Line Up" })
map("v", "<A-Down>", ":m '>+1<cr>gv=gv", { desc = "VS Code: Move Selection Down" })
map("v", "<A-Up>", ":m '<-2<cr>gv=gv", { desc = "VS Code: Move Selection Up" })
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Line Down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move Line Up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move Selection Down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move Selection Up" })

-- Duplicate Line Down / Up (Shift+Alt+Down / Shift+Alt+Up)
map("n", "<A-S-Down>", "<cmd>t .<cr>", { desc = "VS Code: Duplicate Line Down" })
map("n", "<A-S-Up>", "<cmd>t .-1<cr>", { desc = "VS Code: Duplicate Line Up" })

-- Close Editor Tab / Buffer (Ctrl+w)
map("n", "<C-w>", "<cmd>bdelete<cr>", { desc = "VS Code: Close active tab" })

-- Cycle Tabs (Ctrl+Tab / Ctrl+Shift+Tab & Tab / Shift+Tab)
map("n", "<C-Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next editor tab" })
map("n", "<C-S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous editor tab" })
map("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next editor tab" })
map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous editor tab" })

-- Indent / Outdent in Visual Mode without losing selection
map("v", "<Tab>", ">gv", opts)
map("v", "<S-Tab>", "<gv", opts)

-- Undo / Redo (Ctrl+z / Ctrl+y)
map("n", "<C-z>", "u", { desc = "Undo" })
map("n", "<C-y>", "<C-r>", { desc = "Redo" })
map("i", "<C-z>", "<C-o>u", { desc = "Undo" })

-- Select All (Ctrl+a)
map({ "n", "i" }, "<C-a>", "<esc>gg<S-v>G", { desc = "VS Code: Select All" })

-- Toggle Integrated Terminal (Ctrl+` and Ctrl+~)
map({ "n", "t" }, "<C-`>", "<cmd>ToggleTerm<cr>", { desc = "VS Code: Toggle Integrated Terminal" })
map({ "n", "t" }, "<C-~>", "<cmd>ToggleTerm<cr>", { desc = "VS Code: Toggle Integrated Terminal" })

-- Split Editor (Ctrl+\ vertically, Alt+\ horizontally)
map("n", "<C-\\>", "<cmd>vsplit<cr>", { desc = "VS Code: Split Editor Right" })
map("n", "<A-\\>", "<cmd>split<cr>", { desc = "VS Code: Split Editor Down" })

-- LSP Shortcuts (VS Code standard)
map("n", "<F2>", function()
  if pcall(require, "inc_rename") then
    return ":IncRename " .. vim.fn.expand("<cword>")
  else
    vim.lsp.buf.rename()
  end
end, { expr = true, desc = "VS Code: Rename Symbol (F2)" })

map("n", "<F12>", vim.lsp.buf.definition, { desc = "VS Code: Go to Definition (F12)" })
map("n", "<A-S-f>", function()
  require("conform").format({ lsp_fallback = true, async = false, timeout_ms = 1000 })
end, { desc = "VS Code: Format Document (Shift+Alt+F)" })

-- Git GUI / LazyGit (Ctrl+Shift+G)
map("n", "<C-S-g>", "<cmd>LazyGit<cr>", { desc = "VS Code: Source Control (LazyGit)" })

-- ====================================================================
-- 2. JazzyGrim / Dotfiles Shortcuts
-- ====================================================================
map("n", "x", '"_x')
map("n", "<leader>w", ":update<Return>", opts)
map("n", "<leader>q", ":quit<Return>", opts)
map("n", "<leader>Q", ":qa<Return>", opts)
map("n", "<leader>f", ":NvimTreeFindFile<Return>", opts)
map("n", "<leader>t", ":NvimTreeToggle<Return>", opts)

-- JazzyGrim quick telescope keys
map("n", ";f", function()
  require("telescope.builtin").find_files({ no_ignore = false, hidden = true })
end, { desc = "Telescope find files" })

map("n", ";r", function()
  require("telescope.builtin").live_grep()
end, { desc = "Telescope live grep" })

map("n", "\\\\", function()
  require("telescope.builtin").buffers()
end, { desc = "Telescope buffers" })

map("n", ";e", function()
  require("telescope.builtin").diagnostics()
end, { desc = "Telescope diagnostics" })

map("n", ";s", function()
  require("telescope.builtin").treesitter()
end, { desc = "Telescope symbols" })

-- Window navigation
map("n", "sh", "<C-w>h", opts)
map("n", "sk", "<C-w>k", opts)
map("n", "sj", "<C-w>j", opts)
map("n", "sl", "<C-w>l", opts)

-- Window resize
map("n", "<C-S-h>", "<C-w><", opts)
map("n", "<C-S-l>", "<C-w>>", opts)
map("n", "<C-S-k>", "<C-w>+", opts)
map("n", "<C-S-j>", "<C-w>-", opts)
