-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local Util = require("lazyvim.util")

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- Delete current buffer
map({ "n" }, "<A-w>", "<cmd>bd<cr>")

-- Nop out unused (by me) and often accidentally triggered keymap
map({ "n" }, "<S-j>", "<Nop>")

local function toggle_quickfix()
  local windows = vim.fn.getwininfo()
  for _, win in pairs(windows) do
    if win["quickfix"] == 1 then
      vim.cmd.cclose()
      return
    end
  end
  vim.cmd.copen()
end

-- Quick toggle/removal of quickfix/Trouble
map({ "n" }, "<A-F>", "<cmd>Trouble close<cr>")
map({ "n" }, "<A-D>", toggle_quickfix)

-- Full root directory search for anything
map({ "n" }, "<C-A-f>", function()
  vim.ui.input({ prompt = "Search: " }, function(search_term)
    if search_term ~= nil and search_term ~= "" then
      vim.api.nvim_cmd({ cmd = "grep", args = { search_term } }, {})
      vim.api.nvim_cmd({ cmd = "Trouble", args = { "quickfix" } }, {})
      vim.api.nvim_cmd({ cmd = "NoiceDismiss" }, {})
    end
  end)
end)

map({ "n" }, "<A-f>", function()
  local search_term = vim.fn.expand("<cword>")
  if search_term ~= nil and search_term ~= "" then
    vim.cmd("grep! " .. search_term)
    vim.api.nvim_cmd({ cmd = "Trouble", args = { "quickfix" } }, {})
    vim.api.nvim_cmd({ cmd = "NoiceDismiss" }, {})

    -- Hack to attach all found files to LSP,
    -- fixes "find references" in some cases.
    local clangd_client = vim.lsp.get_active_clients({ name = "clangd" })[1]
    if clangd_client ~= nil then
      local items = vim.fn.getqflist({ all = 1 }).items
      for _, d in pairs(items) do
        vim.fn.bufload(d.bufnr)
        vim.lsp.buf_attach_client(d.bufnr, clangd_client.id)
      end
    end

    -- Hack to attach first found file to pyright LSP
    -- fixes auto import suggestion in some cases
    local pyright_client = vim.lsp.get_active_clients({ name = "pyright" })[1]
    if pyright_client ~= nil then
      local items = vim.fn.getqflist({ all = 1 }).items
      for _, d in pairs(items) do
        vim.fn.bufload(d.bufnr)
        vim.lsp.buf_attach_client(d.bufnr, pyright_client.id)
        break
      end
    end
  end
end)

-- Generic LSP, always mapped
map({ "n" }, "<A-r>", function()
  vim.api.nvim_cmd({ cmd = "Trouble", args = { "lsp_references", "open" } }, {})
  vim.api.nvim_cmd({ cmd = "Trouble", args = { "lsp_references", "refresh" } }, {})
end)

-- nvim-tree
map({ "n" }, "<C-E>", "<cmd>NvimTreeToggle<cr>")
