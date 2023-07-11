return {
  -- configure cpptools dap so that it can accept arguments
  {
    "jay-babu/mason-nvim-dap.nvim",
    keys = {
      {
        "<F7>",
        function()
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
      handlers = {
        function(config)
          -- all sources with no handler get passed here
          -- Keep original functionality
          require("mason-nvim-dap").default_setup(config)
        end,

        cppdbg = function(config)
          require("dap.ext.vscode").load_launchjs(nil, { cppdbg = { "c", "cpp", "h", "hpp" } })
          local configurations = {}
          if vim.g.cmake_target_configs then
            vim.list_extend(configurations, vim.g.cmake_target_configs)
          end
          vim.list_extend(configurations, config.configurations)
          config.configurations = configurations
          require("mason-nvim-dap").default_setup(config)
        end,
      },
    },
  },
}
