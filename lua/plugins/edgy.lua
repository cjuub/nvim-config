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
      -- toggleterm / lazyterm at the bottom with a height of 40% of the screen
      {
        ft = "toggleterm",
        size = { height = 0.4 },
        -- exclude floating windows
        filter = function(buf, win)
          return vim.api.nvim_win_get_config(win).relative == ""
        end,
      },
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
        title = "Output",
        size = { height = 0.6 },
      },
      {
        ft = "help",
        size = { height = 20 },
        -- only show help buffers
        filter = function(buf)
          return vim.bo[buf].buftype == "help"
        end,
      },
      { ft = "spectre_panel", size = { height = 0.4 } },
    },
    animate = {
      enabled = false,
    },
  },
}
