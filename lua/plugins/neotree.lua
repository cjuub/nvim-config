return {
  "nvim-neo-tree/neo-tree.nvim",
  keys = {
    { "<leader>fe", false },
    { "<leader>fE", false },
    {
      "<leader>E",
      function()
        require("neo-tree.command").execute({ toggle = true, dir = require("lazyvim.util").get_root() })
      end,
      desc = "Explorer NeoTree (root dir)",
    },
    {
      "<leader>e",
      function()
        require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
      end,
      desc = "Explorer NeoTree (cwd)",
    },
    { "<C-E>", "<leader>e", desc = "Explorer NeoTree (cwd)", remap = true },
  },
}
