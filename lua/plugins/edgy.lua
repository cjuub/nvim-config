return {
  "folke/edgy.nvim",
  event = "VeryLazy",
  init = function()
    vim.opt.laststatus = 3
    vim.opt.splitkeep = "screen"
  end,
  opts = {
    right = {
      {
        ft = "copilot-chat",
        title = "Copilot Chat",
        size = { width = 100 },
      },
    },
    bottom = {
      {
        ft = "snacks_terminal",
        title = "Terminal",
        size = { height = 0.6 },
        filter = function(_buf, win)
          return vim.w[win].snacks_win and vim.w[win].snacks_win.relative == "editor" and not vim.w[win].trouble_preview
        end,
      },
      {
        ft = "qf",
        title = "",
        size = { height = 0.6 },
      },
    },
    animate = {
      enabled = false,
    },
  },
}
