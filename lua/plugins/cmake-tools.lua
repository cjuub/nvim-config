local function load_current_cmake_targets_to_dap()
  local cmake_tools = require("cmake-tools")
  if cmake_tools.is_cmake_project() then
    cmake_tools.get_cmake_launch_targets(function(targets)
      local target_configs = {}
      local build_type = tostring(cmake_tools.get_build_type().value)
      local launch_target = cmake_tools.get_launch_target()

      for k, v in pairs(targets.data.targets) do
        if v == launch_target then
          table.insert(target_configs, 1, {
            name = "* " .. v .. " [" .. build_type .. "]",
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

          -- Add dummy separator between selected target and the rest
          table.insert(target_configs, 2, {
            name = "---",
          })
        end

        table.insert(target_configs, {
          name = v .. " [" .. build_type .. "]",
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

      local dap = require("dap")
      dap.configurations.cpp = {}
      vim.list_extend(dap.configurations.cpp, target_configs)
    end)
  end
end

return {
  {
    "cjuub/cmake-tools.nvim",
    branch = "remove-dap-dependency",
    keys = {
      {
        "<F7>",
        function()
          load_current_cmake_targets_to_dap()
          require("dap").continue()
        end,
        desc = "Debug (start/continue)",
      },
      {
        "<F8>",
        function()
          require("dap").run_last()
        end,
        desc = "Debug (restart)",
      },
      {
        "<F12>",
        function()
          require("dap").terminate()
          require("dapui").close()
          vim.cmd("Neotree show")
        end,
        desc = "Debug (stop)",
      },
    },
    opts = {
      cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
      cmake_build_options = { "-j32" },
      cmake_soft_link_compile_commands = true,
      cmake_dap_configuration = { -- debug settings for cmake
        name = "cpp",
        type = "cppdbg",
        request = "launch",
        stopOnEntry = false,
        runInTerminal = true,
        console = "integratedTerminal",
      },
    },
  },
}
