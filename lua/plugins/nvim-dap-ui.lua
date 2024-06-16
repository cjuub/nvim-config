return {
  "rcarriga/nvim-dap-ui",
  opts = {
    layouts = {
      {
        elements = {
          -- Elements can be strings or table with id and size keys.
          -- { id = "scopes", size = 0.25 },
          "scopes",
          "stacks",
          "breakpoints",
        },
        size = 0.35,
        position = "left",
      },
      {
        elements = {
          "repl",
        },
        size = 0.25,
        position = "bottom",
      },
      {
        elements = {
          "console",
          -- { id = "console", size = 0.2 },
        },
        size = 0.25,
        position = "top",
      },
    },
  },
  config = function(_, opts)
    local dap = require("dap")
    local dapui = require("dapui")

    dapui.setup(opts)
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open({})
    end
  end,
}
