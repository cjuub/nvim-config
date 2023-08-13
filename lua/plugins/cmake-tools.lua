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
            require("helpers.cmake-tools").load_current_cmake_targets_to_dap(function()
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
