return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      ruff = {
        root_dir = function()
          return vim.fn.getcwd()
        end,
      },
      basedpyright = {
        root_dir = function()
          return vim.fn.getcwd()
        end,
        keys = {
          {
            "<C-A-p>",
            function()
              vim.api.nvim_cmd({ cmd = "LspRestart" }, {})
            end,
            desc = "Restart LSP",
          },
          {
            "<A-backspace>",
            function()
              vim.lsp.buf.code_action()
            end,
            desc = "Code action",
          },
          {
            "<A-i>",
            function()
              vim.lsp.buf.hover()
            end,
            desc = "Show symbol information",
          },
          {
            "<A-d>",
            function()
              vim.diagnostic.open_float()
            end,
            desc = "Show diagnostic information",
          },
        },
      },
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
            desc = "Restart LSP",
          },
          {
            "<A-backspace>",
            function()
              vim.lsp.buf.code_action()
            end,
            desc = "Code action",
          },
          {
            "<A-i>",
            function()
              vim.lsp.buf.hover()
            end,
            desc = "Show symbol information",
          },
          {
            "<A-d>",
            function()
              vim.diagnostic.open_float()
            end,
            desc = "Show diagnostic information",
          },
        },
        cmd = {
          "clangd",
          "--background-index",
          "--background-index-priority=normal",
          "--clang-tidy",
          "--header-insertion=iwyu",
          "--completion-style=detailed",
          "--function-arg-placeholders",
          "--fallback-style=llvm",
          "--offset-encoding=utf-16",
          "--query-driver=**",
        },
      },
    },
  },
}
