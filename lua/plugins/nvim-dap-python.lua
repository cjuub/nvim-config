return {
  "mfussenegger/nvim-dap-python",
  keys = {
    {
      "<F9>",
      require("dap").continue,
      desc = "Debug (start/continue)",
    },
    {
      "<F12>",
      require("helpers.dap").close_debug_session,
      desc = "Debug (stop)",
    },
  },
}
