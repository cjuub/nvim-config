return {
  "nvim-neo-tree/neo-tree.nvim",
  keys = {
    { "<leader>fe", false },
    { "<leader>fE", false },
    { "<leader>e", false },
    { "<leader>E", false },
    {
      "<C-E>",
      function()
        require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
      end,
      desc = "Sidebar",
    },
  },
}
