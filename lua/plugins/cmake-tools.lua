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
          require("helpers.cmake-tools").select_presets,
          desc = "Select CMakePresets",
        },
        {
          "<F2>",
          require("helpers.cmake-tools").select_build_target,
          desc = "Select launch target",
        },
        {
          "<F3>",
          require("helpers.cmake-tools").select_launch_target,
          desc = "Select launch target",
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
          "<F9>",
          require("helpers.cmake-tools").debug,
          desc = "Debug (start/continue)",
        },
        {
          "<F12>",
          require("helpers.cmake-tools").close_debug_session,
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
