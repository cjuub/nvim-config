local Util = require("lazyvim.util")

return {
  {
    "nvim-telescope/telescope.nvim",
    defaults = {},
    keys = {
      { "<leader>fb", false },
      { "<leader>fc", false },
      { "<leader>ff", false },
      { "<leader>fF", false },
      { "<leader>fg", false },
      { "<leader>fr", false },
      { "<leader>fR", false },
      { "<leader>:", false },
      {
        "<leader>gb",
        require("telescope.builtin").git_bcommits,
        desc = "Commits (current file)",
      },
      { "<leader>/", Util.telescope("live_grep", { cwd = vim.fn.getcwd() }), desc = "Find in Files" },
      {
        "<leader><space>",
        function()
          require("telescope.builtin").find_files({
            cwd = vim.fn.getcwd(),
          })
        end,
        desc = "Find Files",
      },
      {
        "<leader>r",
        function()
          require("telescope.builtin").resume({})
        end,
        desc = "Resume Search",
      },
      {
        "<leader>fc",
        function()
          require("telescope.builtin").find_files({
            find_command = {
              "rg",
              "--files",
              "--color",
              "never",
              "--glob",
              "*.cpp",
              "--glob",
              "*.h",
              "--glob",
              "*.hpp",
            },
            cwd = vim.fn.getcwd(),
          })
        end,
        desc = "Find Source Files (C++)",
      },
      {
        "<leader>fp",
        function()
          require("telescope.builtin").find_files({
            find_command = {
              "rg",
              "--files",
              "--color",
              "never",
              "--glob",
              "*.py",
            },
            cwd = vim.fn.getcwd(),
          })
        end,
        desc = "Find Source Files (Python)",
      },
      {
        "<leader>fa",
        function()
          require("telescope.builtin").find_files({
            cwd = vim.fn.getcwd(),
            no_ignore = true,
            no_ignore_parent = true,
            hidden = true,
          })
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
