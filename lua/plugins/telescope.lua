return {
  {
    "nvim-telescope/telescope.nvim",
    defaults = {},
    keys = {
      {
        "<leader>gb",
        require("telescope.builtin").git_bcommits,
        desc = "Commits (current file)",
      },
      {
        "<leader>fa",
        function()
          require("telescope.builtin").find_files({ no_ignore = true, hidden = true })
        end,
        desc = "Find Files (all)",
      },
    },
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
        mappings = { i = { ["<esc>"] = require("telescope.actions").close } },
      },
    },
  },
  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  },
}
