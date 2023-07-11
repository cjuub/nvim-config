return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
  keys = {
    {
      "<A-h>",
      function()
        vim.api.nvim_cmd({ cmd = "DiffviewFileHistory", args = { "%" } }, {})
      end,
      desc = "History",
    },
    {
      "<A-H>",
      function()
        vim.api.nvim_cmd({ cmd = "tabclose" }, {})
      end,
      desc = "Close History",
    },
  },
}
