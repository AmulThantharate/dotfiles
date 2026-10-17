# ☁️ Cloud DevOps Neovim IDE (Dotfiles)

> High-performance, transparent Neovim setup built for **Cloud & DevOps Engineers** with intuitive **VS Code keybindings** and a modular architecture inspired by [JazzyGrim's dotfiles](https://github.com/JazzyGrim/dotfiles).

![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?style=for-the-badge&logo=neovim&logoColor=white)
![Lua](https://img.shields.io/badge/lua-%232C2D72.svg?style=for-the-badge&logo=lua&logoColor=white)
![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)
![Kubernetes](https://img.shields.io/badge/kubernetes-%23326ce5.svg?style=for-the-badge&logo=kubernetes&logoColor=white)
![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)
![Ansible](https://img.shields.io/badge/ansible-%23EE0000.svg?style=for-the-badge&logo=ansible&logoColor=white)

---

## ✨ Features

- 🌌 **True 100% Transparent Background**: Configured with **Catppuccin Mocha** (plus Tokyo Night & Sonokai options) and an automated highlight transparency enforcer for buffers, file tree, Telescope, and floating windows.
- ⌨️ **VS Code Muscle Memory**: Use standard `Ctrl+S`, `Ctrl+N`, `Ctrl+P`, `Ctrl+B`, `Ctrl+Shift+F`, `Ctrl+/`, `Alt+Up/Down`, `Ctrl+Tab`, `Ctrl+W`, `Ctrl+~` and more.
- 🚀 **Full Cloud DevOps Stack**: Out-of-the-box LSP, autocompletion, schema validation, linting, and formatting for Infrastructure as Code, Containers, CI/CD, and Cloud scripts.
- 🗂️ **JazzyGrim Architecture**: Clean, modular structure (`lua/config` and `lua/plugins`) with fast lazy-loading powered by `lazy.nvim`.
- 🪟 **Modern UI**: Floating filename badges with filetype icons (`b0o/incline.nvim`), VS Code editor tabs (`bufferline.nvim`), floating terminal (`toggleterm.nvim`), and Git terminal GUI (`lazygit.nvim`).

---

## 🛠️ Cloud DevOps Toolchain

| Category | Languages / Tools | LSP & Linters / Formatters |
| :--- | :--- | :--- |
| **Infrastructure as Code** | Terraform, OpenTofu, Terragrunt, HCL | `terraformls`, `terraform_fmt` |
| **Containers & Orchestration** | Dockerfile, Containerfile, Docker Compose | `dockerls`, `docker_compose_language_service` |
| **Kubernetes & Cloud Native** | Kubernetes Manifests, Helm Templates | `yamlls` (with SchemaStore Kubernetes schemas) |
| **Configuration Management** | Ansible Playbooks, Roles, Tasks, Inventories | `ansiblels`, `yamlls` |
| **CI / CD Pipelines** | Jenkinsfile, Groovy Pipelines, GitHub Actions | `groovyls` LSP, Jenkins/Groovy snippets, `yamlls` |
| **Automation Scripting** | Python, Bash / Shell (Zsh, Sh) | `pyright`, `black`, `bashls`, `shfmt`, `shellcheck` |
| **Data & Configuration** | YAML, JSON, TOML | `yamlls`, `jsonls`, `prettier` |
| **Databases** | PostgreSQL, MySQL, SQLite | `vim-dadbod-ui` interactive SQL client |
| **Editor Config** | Lua, Markdown, Gitignore | `lua_ls`, `stylua`, `marksman` |

---

## ⌨️ VS Code Keybindings

| Keybinding | Action | Mode |
| :--- | :--- | :--- |
| `Ctrl + S` | Save current file | Normal, Insert, Visual |
| `Ctrl + N` | Create a new blank file / buffer | Normal, Insert |
| `Ctrl + P` | Quick Open / Search Files | Normal |
| `Ctrl + Shift + P` | Command Palette | Normal |
| `Ctrl + B` | Toggle File Explorer Sidebar (`NvimTree`) | Normal |
| `Ctrl + F` | Find in current buffer | Normal |
| `Ctrl + Shift + F` | Search across all project files (`live_grep`) | Normal |
| `Ctrl + /` or `Ctrl + _` | Toggle comment line / block | Normal, Visual |
| `Alt + Up` / `Alt + Down` | Move current line or selection Up / Down | Normal, Insert, Visual |
| `Alt + k` / `Alt + j` | Move current line or selection Up / Down | Normal, Visual |
| `Shift + Alt + Down` | Duplicate line downwards | Normal |
| `Shift + Alt + Up` | Duplicate line upwards | Normal |
| `Tab` / `Shift + Tab` | Indent / Outdent selection without losing highlight | Visual |
| `Ctrl + Tab` / `Ctrl + Shift + Tab` | Next / Previous editor tab | Normal |
| `Tab` / `Shift + Tab` | Next / Previous editor tab | Normal |
| `Ctrl + W` | Close current editor tab / buffer | Normal |
| `Ctrl + Z` / `Ctrl + Y` | Undo / Redo | Normal, Insert |
| `Ctrl + A` | Select All (`ggVG`) | Normal, Insert |
| `Ctrl + \`` or `Ctrl + ~` | Toggle Integrated Floating Terminal | Normal, Terminal |
| `Ctrl + \` | Split Editor Vertically | Normal |
| `Alt + \` | Split Editor Horizontally | Normal |
| `F2` | Rename Symbol (with `IncRename`) | Normal |
| `F12` | Go to Definition | Normal |
| `Shift + Alt + F` | Format Document (`conform.nvim`) | Normal |
| `Ctrl + Shift + G` | Open Git Source Control (`LazyGit`) | Normal |

### 🧭 JazzyGrim Fast Navigation

- `;f` - Find files
- `;r` - Live grep search
- `\\` - List open buffers
- `;e` - Diagnostics list
- `;s` - Treesitter symbols
- `<leader>w` - Save file
- `<leader>q` - Quit window
- `<leader>Q` - Quit all
- `sh` / `sk` / `sj` / `sl` - Window split navigation (Left / Up / Down / Right)
- `Ctrl + Shift + H/J/K/L` - Resize window splits

---

## 📂 Repository Structure

```
dotfiles/
├── .config/
│   └── nvim/
│       ├── init.lua                   # Entry point & 0.9 compatibility polyfills
│       ├── lua/
│       │   ├── config/
│       │   │   ├── options.lua        # General editor options & UI settings
│       │   │   ├── lazy.lua           # Lazy.nvim package manager setup
│       │   │   ├── autocmds.lua       # Cloud DevOps filetype associations
│       │   │   └── keymaps.lua        # VS Code & JazzyGrim keybindings
│       │   └── plugins/
│       │       ├── colorscheme.lua    # Sonokai Andromeda + 100% Transparent background
│       │       ├── devops.lua         # LSP, Treesitter, Mason, SchemaStore, Completion
│       │       ├── ui.lua             # Incline pill, Bufferline, NvimTree, Lualine
│       │       ├── editor.lua         # Telescope, FZF, Gitsigns, Comments
│       │       └── integrations.lua   # LazyGit, DBUI, ToggleTerm, IncRename
├── .gitignore
└── README.md
```

---

## 🚀 Installation & Quickstart

### 1. Clone the repository
```bash
git clone https://github.com/AmulThantharate/dotfiles.git ~/dotfiles
```

### 2. Symlink Neovim configuration
```bash
# Backup existing config if needed
mv ~/.config/nvim ~/.config/nvim.backup 2>/dev/null || true

# Symlink to dotfiles
ln -s ~/dotfiles/.config/nvim ~/.config/nvim
```

### 3. Launch Neovim
```bash
nvim
```
Plugins, language servers, treesitter parsers, and the transparent theme will automatically install on first launch.
