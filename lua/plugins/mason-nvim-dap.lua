return {
  {
    "jay-babu/mason-nvim-dap.nvim",
    lazy = false,
    opts = {
      ensure_installed = {
        "debugpy",
      },
      handlers = {
        function(config)
          -- all sources with no handler get passed here
          -- Keep original functionality
          require("mason-nvim-dap").default_setup(config)
        end,

        cppdbg = function(config)
          -- Remove default unused configurations, let cmake-tools load its
          -- detected executable targets instead
          config.configurations = {}
          require("mason-nvim-dap").default_setup(config)
        end,
      },
    },
  },
}
