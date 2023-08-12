local function load_current_cmake_targets_to_dap(callback)
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

      if callback then
        callback()
      end
    end)
  end
end

return {
  {
    "Civitasv/cmake-tools.nvim",
    init = function()
      require("lspconfig").clangd.setup({
        on_new_config = function(new_config, new_cwd)
          local status, cmake = pcall(require, "cmake-tools")
          if status then
            cmake.clangd_on_new_config(new_config)
          end
        end,
      })
    end,
    keys = function()
      if not require("cmake-tools").is_cmake_project() then
        return {}
      end

      return {
        {
          "<F1>",
          function()
            require("cmake-tools").select_configure_preset()
          end,
          desc = "Select CMakePreset",
        },
        {
          "<F2>",
          function()
            require("cmake-tools").select_launch_target({}, {})
          end,
          desc = "Select CMakePreset",
        },
        {
          "<F4>",
          function()
            require("trouble").close()
            require("cmake-tools").generate({}, function() end)
          end,
          desc = "Run CMake",
        },
        {
          "<F5>",
          function()
            require("trouble").close()
            require("cmake-tools").build({}, function() end)
          end,
          desc = "Build selected build target",
        },
        {
          "<F6>",
          function()
            require("trouble").close()
            require("cmake-tools").quick_build({ fargs = {} }, function() end)
          end,
          desc = "Build from target selection",
        },
        {
          "<F7>",
          function()
            require("trouble").close()
            load_current_cmake_targets_to_dap(function()
              vim.cmd("cclose")
              require("dap").continue()
            end)
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
      }
    end,
    opts = {
      cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
      cmake_build_options = { "-j32" },
      cmake_soft_link_compile_commands = false,
      cmake_dap_configuration = { -- debug settings for cmake
        name = "cpp",
        type = "cppdbg",
        request = "launch",
        stopOnEntry = false,
        runInTerminal = true,
        console = "integratedTerminal",
      },
      cmake_executor = {
        name = "quickfix", -- name of the executor
        opts = {}, -- the options the executor will get, possible values depend on the executor type. See `default_opts` for possible values.
        default_opts = { -- a list of default and possible values for executors
          quickfix = {
            show = "always", -- "always", "only_on_error"
            position = "belowright", -- "bottom", "top"
            size = 20,
          },
        },
      },
      cmake_notifications = {
        enabled = false, -- show cmake execution progress in nvim-notify
        spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }, -- icons used for progress display
        refresh_rate_ms = 100, -- how often to iterate icons
      },
    },
  },
}
