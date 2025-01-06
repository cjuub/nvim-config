return {
  "ibhagwan/fzf-lua",
  opts = function(_, opts)
    local fzf = require("fzf-lua")
    local config = fzf.config
    config.defaults.keymap.builtin["<Esc>"] = "hide"
  end,
  keys = {
    { "<leader>r", "<cmd>FzfLua live_grep resume<cr>", desc = "Resume Last Search" },
    { "<leader>/", LazyVim.pick("live_grep", { rg_glob = true }), desc = "Find in Files" },
    { "<leader><space>", LazyVim.pick("files"), desc = "Find Files" },

    { "<leader>fc", false }, -- find config files
    { "<leader>fR", false }, -- find recents CWD

    { "<leader>ff", LazyVim.pick("files"), desc = "Find Files" },
    { "<leader>fF", LazyVim.pick("live_grep", { rg_glob = true, rg_color = true }), desc = "Find in Files" },
  },
}
