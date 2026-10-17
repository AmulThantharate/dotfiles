local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- DevOps & Cloud Filetype Associations
vim.filetype.add({
  filename = {
    ["Jenkinsfile"] = "groovy",
    ["Containerfile"] = "dockerfile",
    ["inventory"] = "ini",
    ["ansible.cfg"] = "ini",
  },
  pattern = {
    -- Jenkins & Groovy pipelines
    ["Jenkinsfile.*"] = "groovy",
    [".*%.jenkinsfile"] = "groovy",
    [".*%.pipeline"] = "groovy",

    -- Docker & Containers
    ["Dockerfile.*"] = "dockerfile",
    [".*%.dockerfile"] = "dockerfile",

    -- Docker Compose
    ["docker%-compose.*%.ya?ml"] = "yaml.docker-compose",
    ["compose.*%.ya?ml"] = "yaml.docker-compose",

    -- Ansible Playbooks & Roles
    [".*playbook.*%.ya?ml"] = "yaml.ansible",
    [".*/playbooks/.*%.ya?ml"] = "yaml.ansible",
    [".*/roles/.*/tasks/.*%.ya?ml"] = "yaml.ansible",
    [".*/roles/.*/handlers/.*%.ya?ml"] = "yaml.ansible",
    [".*/tasks/.*%.ya?ml"] = "yaml.ansible",
    [".*/handlers/.*%.ya?ml"] = "yaml.ansible",
    [".*/group_vars/.*%.ya?ml"] = "yaml.ansible",
    [".*/host_vars/.*%.ya?ml"] = "yaml.ansible",

    -- Terraform & OpenTofu / HCL
    [".*%.tf"] = "terraform",
    [".*%.tfvars"] = "terraform",
    [".*%.hcl"] = "hcl",
    ["terragrunt%.hcl"] = "hcl",

    -- Helm & Kubernetes Templates
    [".*/templates/.*%.ya?ml"] = "yaml",
    [".*/templates/.*%.tpl"] = "helm",
  },
})

-- Highlight yanked text
local yank_group = augroup("HighlightYank", { clear = true })
autocmd("TextYankPost", {
  group = yank_group,
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
  end,
})

-- Equalize window splits when terminal is resized
local resize_group = augroup("ResizeSplits", { clear = true })
autocmd("VimResized", {
  group = resize_group,
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- Close helper windows with <q>
local close_with_q = augroup("CloseWithQ", { clear = true })
autocmd("FileType", {
  group = close_with_q,
  pattern = {
    "qf",
    "help",
    "man",
    "notify",
    "lspinfo",
    "checkhealth",
    "startuptime",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- Terminal window settings (enter insert mode automatically)
local term_group = augroup("TermSettings", { clear = true })
autocmd("TermOpen", {
  group = term_group,
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.cmd("startinsert")
  end,
})
