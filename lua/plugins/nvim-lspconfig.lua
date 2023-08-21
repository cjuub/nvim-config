return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      clangd = {
        on_new_config = function(new_config, new_cwd)
          local status, cmake = pcall(require, "cmake-tools")
          if status then
            cmake.clangd_on_new_config(new_config)
          end
        end,

        keys = {
          { "<A-o>", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
          {
            "<C-A-p>",
            function()
              vim.api.nvim_cmd({ cmd = "LspStop" }, {})
              vim.api.nvim_cmd({ cmd = "LspStart" }, {})
            end,
            desc = "Switch Source/Header (C/C++)",
          },
          {
            "<A-enter>",
            function()
              vim.lsp.buf.code_action()
            end,
          },
          {
            "<A-backspace>",
            function()
              vim.lsp.buf.hover()
            end,
          },
          {
            "<A-d>",
            function()
              vim.diagnostic.open_float()
            end,
          },
        },
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=iwyu",
          "--completion-style=detailed",
          "--function-arg-placeholders",
          "--fallback-style=llvm",
          "--query-driver=**",
        },
      },
    },
  },
}