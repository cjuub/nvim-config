return {
  load_current_cmake_targets_to_dap = function(callback)
    local cmake_tools = require("cmake-tools")
    if cmake_tools.is_cmake_project() then
      cmake_tools.get_cmake_launch_targets(function(targets)
        local target_configs = {}
        local build_type = tostring(cmake_tools.get_build_type().value)
        local launch_target = cmake_tools.get_launch_target()

        local launch_target_config = nil
        for k, v in pairs(targets.data.targets) do
          if v == launch_target then
            launch_target_config = {
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
            }

            table.insert(target_configs, 1, launch_target_config)
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

        if callback then
          callback(launch_target_config)
        end
      end)
    end
  end,
}
