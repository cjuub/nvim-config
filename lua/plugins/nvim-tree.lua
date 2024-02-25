return {
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      local function my_on_attach(bufnr)
        local api = require("nvim-tree.api")
        api.config.mappings.default_on_attach(bufnr)
        vim.keymap.del("n", "<C-e>", { buffer = bufnr })

        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- Only automatically close window when file is selected
        vim.keymap.set("n", "<CR>", function()
          api.node.open.edit()
          if api.tree.is_tree_buf() ~= true then
            api.tree.toggle()
          end
        end, opts("Open"))
      end

      local nvim_tree = require("nvim-tree")
      nvim_tree.setup({
        on_attach = my_on_attach,
        update_focused_file = { enable = true, update_root = false },
        select_prompts = true,
        filters = { dotfiles = true },
        view = {
          float = {
            enable = true,
            quit_on_focus_loss = false,
            open_win_config = {
              relative = "editor",
              width = 100,
              height = 100,
            },
          },
        },
      })
    end,
  },
}
