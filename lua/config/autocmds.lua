-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("BufReadPre", {
  group = augroup("neotree_autoopen"),
  callback = function()
    if not vim.g.neotree_opened then
      vim.cmd("Neotree show")
      vim.g.neotree_opened = true
    end
  end,
})

vim.api.nvim_create_autocmd("BufReadPre", {
  group = augroup("cmake_load_targets"),
  callback = function()
    if not vim.g.cmake_targets_loaded then
      local cmake_tools = require("cmake-tools")
      if cmake_tools.is_cmake_project() then
        cmake_tools.get_cmake_launch_targets(function(targets)
          local target_configs = {}
          local build_type = tostring(cmake_tools.get_build_type().value)
          for k, v in pairs(targets.data.targets) do
            table.insert(target_configs, {
              name = "(CMake) " .. v .. " (" .. build_type .. ")",
              type = "cppdbg",
              request = "launch",
              args = "",
              program = targets.data.abs_paths[k],
              cwd = "${workspaceFolder}",
              stopAtEntry = false,
              setupCommands = {
                {
                  text = "-enable-pretty-printing",
                  description = "enable pretty printing",
                  ignoreFailures = false,
                },
              },
            })
          end

          vim.g.cmake_target_configs = target_configs
        end)
      end
      vim.g.cmake_targets_loaded = true
    end
  end,
})
