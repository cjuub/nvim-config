-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.autoformat = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.g.lazyvim_python_lsp = "pyright"
vim.g.lazyvim_python_ruff = "ruff"
vim.g.root_spec = { "cwd" }
vim.g.snacks_animate = false
vim.g.lazyvim_cmp = "nvim-cmp"
