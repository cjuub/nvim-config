-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("BufReadPre", {
  group = augroup("venv"),
  pattern = "*",
  callback = function()
    local venv = vim.fn.findfile("venv/bin/activate", vim.fn.getcwd() .. ";")
    if venv ~= "" then
      require("venv-selector").retrieve_from_cache()
    end
  end,
  once = true,
})

vim.api.nvim_create_autocmd({ "BufLeave" }, {
  pattern = { "*" },
  command = "silent! wall",
  nested = true,
})

vim.api.nvim_create_autocmd("BufRead", {
  pattern = "*",
  callback = function()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      local buf_name = vim.api.nvim_buf_get_name(buf)
      local startindex, _ = string.find(buf_name, "*cmake-tools*", 1, true)
      if startindex ~= nil then
        vim.api.nvim_buf_set_option(buf, "buflisted", false)
      end
    end
  end,
  once = true,
})
