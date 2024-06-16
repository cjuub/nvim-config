return {
  {
    "Civitasv/cmake-tools.nvim",
    keys = function()
      if not require("helpers.cmake-tools").is_cmake_project() then
        return false
      end
      return {
        {
          "<F1>",
          require("helpers.cmake-tools").select_presets,
          desc = "Select CMakePresets",
        },
        {
          "<F2>",
          require("helpers.cmake-tools").select_build_target,
          desc = "Select build target",
        },
        {
          "<F4>",
          require("helpers.cmake-tools").configure,
          desc = "Run CMake",
        },
        {
          "<F5>",
          require("helpers.cmake-tools").build,
          desc = "Build selected build target",
        },
        {
          "<F7>",
          require("helpers.cmake-tools").select_launch_target,
          desc = "Select launch target",
        },
        {
          "<F8>",
          require("helpers.cmake-tools").run,
          desc = "Run selected launch target",
        },
        {
          "<F9>",
          function()
            require("dapui").open()
            require("helpers.cmake-tools").debug()
          end,
          desc = "Debug (start/continue)",
        },
        {
          "<F12>",
          require("dapui").toggle,
          desc = "Toggle DAP UI",
        },
        {
          "<C-F12>",
          require("helpers.dap").close_debug_session,
          desc = "Debug (stop)",
        },
      }
    end,
    opts = {
      cmake_soft_link_compile_commands = false,
      cmake_regenerate_on_save = false,
      cmake_virtual_text_support = false,
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
            auto_close_when_success = false,
          },
        },
      },
      cmake_notifications = {
        runner = { enabled = false },
        executor = { enabled = false },
      },
    },
  },
}
