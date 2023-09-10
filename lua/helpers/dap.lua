return {
  close_debug_session = function()
    require("dap").terminate()
    require("dapui").close()
  end,
}
