local function file_exists(name)
  local f = io.open(name, "r")
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end

return {
  "mfussenegger/nvim-dap-python",
  keys = function()
    if not file_exists("pyproject.toml") and not file_exists("setup.py") then
      return false
    end
    return {
      {
        "<F9>",
        function()
          require("dapui").open()
          require("dap").continue()
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
}
