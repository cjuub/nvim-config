return {
  "akinsho/flutter-tools.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "stevearc/dressing.nvim", -- optional for vim.ui.select
  },
  config = true,
  opts = {
    dev_log = {
      enabled = false,
      notify_errors = false, -- if there is an error whilst running then notify the user
      open_cmd = "tabedit", -- command to use to open the log buffer
    },
    debugger = { -- integrate with nvim dap + install dart code debugger
      enabled = true,
      run_via_dap = true, -- use dap instead of a plenary job to run flutter apps
      -- if empty dap will not stop on any exceptions, otherwise it will stop on those specified
      -- see |:help dap.set_exception_breakpoints()| for more info
      exception_breakpoints = {},
    },
    lsp = {
      settings = {
        lineLength = 120,
      },
    },
  },
}
