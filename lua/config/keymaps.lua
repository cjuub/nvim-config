-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
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

-- Refresh UI if too many graphical glitches
map({ "n" }, "<C-p>", "<cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><cr>")

-- Quick toggle/removal of quickfix/Trouble
map({ "n" }, "<A-F>", "<cmd>TroubleToggle<cr>")
map({ "n" }, "<A-D>", "<cmd>cclose<cr>")

-- Full root directory search for anything
map({ "n" }, "<A-f>", function()
  vim.ui.input({ prompt = "Search: " }, function(search_term)
    if search_term ~= nil and search_term ~= "" then
      vim.api.nvim_cmd({ cmd = "grep", args = { search_term } }, {})
      vim.api.nvim_cmd({ cmd = "Trouble", args = { "quickfix" } }, {})
      vim.api.nvim_cmd({ cmd = "NoiceDismiss" }, {})
    end
  end)
end)

-- Generic LSP, always mapped
map({ "n" }, "<A-r>", "<cmd>Trouble lsp_references<cr>")
map({ "n" }, "<C-A-p>", function()
  vim.api.nvim_cmd({ cmd = "LspStop" }, {})
  vim.api.nvim_cmd({ cmd = "LspStart" }, {})
end)

-- CMake/C++
local cmake_tools = require("cmake-tools")
if cmake_tools.is_cmake_project() then
  map({ "n" }, "<F1>", function()
    cmake_tools.select_configure_preset(function()
      cmake_tools.select_build_preset()
    end)
  end)
  map({ "n" }, "<F4>", function()
    cmake_tools.generate({}, function() end)
  end)
  map({ "n" }, "<F5>", "<cmd>CMakeBuild<cr>")
  map({ "n" }, "<F6>", "<cmd>CMakeQuickBuild<cr>")

  map({ "n" }, "<A-o>", "<cmd>ClangdSwitchSourceHeader<cr>")
end
