-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("neotree_autoopen"),
  callback = function()
    if not vim.g.neotree_opened then
      vim.cmd("Neotree show")
      vim.g.neotree_opened = true
    end
  end,
})

vim.api.nvim_create_autocmd("BufReadPre", {
  group = augroup("cmake_auto_configure"),
  callback = function()
    if not vim.g.cmake_auto_configured then
      if require("cmake-tools").is_cmake_project() then
        require("cmake-tools").generate({}, function()
          vim.cmd("cclose")
        end)
        vim.g.cmake_auto_configured = true
      end
    end
  end,
})
