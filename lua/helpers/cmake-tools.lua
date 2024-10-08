local function load_current_cmake_targets_to_dap(callback)
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
end

local function file_exists(name)
  local f = io.open(name, "r")
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end

return {
  is_cmake_project = function()
    return file_exists("CMakeLists.txt")
  end,
  configure = function()
    require("cmake-tools").generate({}, function() end)
  end,
  build = function()
    require("cmake-tools").quick_build({ fargs = { require("cmake-tools").get_build_target() } })
  end,
  run = function()
    load_current_cmake_targets_to_dap(function(launch_target_config)
      vim.cmd("cclose")
      require("dap").run(launch_target_config)
    end)
  end,
  debug = function()
    load_current_cmake_targets_to_dap(function(launch_target_config)
      vim.cmd("cclose")
      require("dap").run(launch_target_config)
    end)
  end,
  select_build_target = function()
    require("cmake-tools").select_build_target({}, {})
  end,
  select_launch_target = function()
    require("cmake-tools").select_launch_target({}, {})
  end,
  select_configure_preset = function()
    require("cmake-tools").select_configure_preset()
  end,
  select_build_preset = function()
    require("cmake-tools").select_build_preset()
  end,
  select_presets = function()
    require("cmake-tools").select_configure_preset(function()
      require("cmake-tools").select_build_preset()
    end)
  end,
}
