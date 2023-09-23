local Util = require("lazyvim.util")

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
      { "<leader>/", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
      { "<leader><space>", Util.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
      {
        "<leader>fa",
        function()
          require("telescope.builtin").find_files({
            cwd = false,
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
