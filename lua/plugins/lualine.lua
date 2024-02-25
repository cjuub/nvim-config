return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function()
    local icons = require("lazyvim.config").icons
    local Util = require("lazyvim.util")

    -- you can find the icons from https://github.com/Civitasv/runvim/blob/master/lua/config/icons.lua
    local vscode_icons = {
      kind = {
        Text = "󰦨 ",
        Method = " ",
        Function = " ",
        Constructor = " ",
        Field = " ",
        Variable = " ",
        Class = " ",
        Interface = " ",
        Module = " ",
        Property = " ",
        Unit = " ",
        Value = "󰾡 ",
        Enum = " ",
        Keyword = " ",
        Snippet = " ",
        Color = " ",
        File = " ",
        Reference = " ",
        Folder = " ",
        EnumMember = " ",
        Constant = " ",
        Struct = " ",
        Event = " ",
        Operator = " ",
        TypeParameter = " ",
        Specifier = " ",
        Statement = "",
        Recovery = " ",
        TranslationUnit = " ",
        PackExpansion = " ",
      },
      type = {
        Array = " ",
        Number = " ",
        String = " ",
        Boolean = " ",
        Object = " ",
        Template = " ",
      },
      documents = {
        File = "",
        Files = "",
        Folder = "",
        OpenFolder = "",
        EmptyFolder = "",
        EmptyOpenFolder = "",
        Unknown = "",
        Symlink = "",
        FolderSymlink = "",
      },
      git = {
        Add = " ",
        Mod = " ",
        Remove = " ",
        Untrack = " ",
        Rename = " ",
        Diff = " ",
        Repo = " ",
        Branch = " ",
        Unmerged = " ",
      },
      ui = {
        Lock = "",
        TinyCircle = "",
        Circle = "",
        BigCircle = "",
        BigUnfilledCircle = "",
        CircleWithGap = "",
        LogPoint = "",
        Close = "",
        NewFile = "",
        Search = "",
        Lightbulb = "",
        Project = "",
        Dashboard = "",
        History = "",
        Comment = "",
        Bug = "",
        Code = "",
        Telescope = " ",
        Gear = "",
        Package = "",
        List = "",
        SignIn = "",
        Check = "",
        Fire = " ",
        Note = "",
        BookMark = "",
        Pencil = " ",
        -- ChevronRight = "",
        ChevronRight = ">",
        Table = "",
        Calendar = "",
        Line = "▊",
        Evil = "",
        Debug = "",
        Run = "",
        VirtualPrefix = "",
        Next = "",
        Previous = "",
        Configure = "",
      },
      diagnostics = {
        Error = " ",
        Warning = " ",
        Information = " ",
        Question = " ",
        Hint = " ",
      },
      misc = {
        Robot = "󰚩 ",
        Squirrel = "  ",
        Tag = " ",
      },
    }

    return {
      options = {
        theme = "auto",
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard", "alpha" } },
      },
      sections = {
        lualine_a = {
          "mode",
        },
        lualine_b = {
          "branch",
        },
        lualine_c = {
          {
            "diagnostics",
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
          -- stylua: ignore
          {
            function() return require("nvim-navic").get_location() end,
            cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end,
          },
        },
        lualine_x = {
          -- stylua: ignore
          {
            function() return require("noice").api.status.command.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
            color = Util.ui.fg("Statement"),
          },
          -- stylua: ignore
          {
            function() return require("noice").api.status.mode.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
            color = Util.ui.fg("Constant"),
          },
          -- stylua: ignore
          {
            function() return "  " .. require("dap").status() end,
            cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
            color = Util.ui.fg("Debug"),
          },
          { require("lazy.status").updates, cond = require("lazy.status").has_updates, color = Util.ui.fg("Special") },
          {
            "diff",
            symbols = {
              added = icons.git.added,
              modified = icons.git.modified,
              removed = icons.git.removed,
            },
          },
        },
        lualine_y = {
          { "progress", separator = " ", padding = { left = 1, right = 0 } },
          { "location", padding = { left = 0, right = 1 } },
        },
        lualine_z = {
          {
            function()
              return " " .. vscode_icons.ui.Configure .. " "
            end,
            padding = { left = 1, right = 0 },
            separator = "",
            cond = require("helpers.cmake-tools").is_cmake_project,
            on_click = function(n, mouse)
              if n == 1 then
                if mouse == "l" then
                  require("helpers.cmake-tools").configure()
                end
              end
            end,
          },
          {
            function()
              local c_preset = require("cmake-tools").get_configure_preset()
              return "[" .. (c_preset and c_preset or "X") .. "]"
            end,
            cond = function()
              return require("helpers.cmake-tools").is_cmake_project() and require("cmake-tools").has_cmake_preset()
            end,
            on_click = function(n, mouse)
              if n == 1 then
                if mouse == "l" then
                  require("helpers.cmake-tools").select_configure_preset()
                end
              end
            end,
          },
          {
            function()
              return " " .. vscode_icons.ui.Gear .. " "
            end,
            padding = { left = 1, right = 0 },
            separator = "",
            -- icon = vscode_icons.ui.Gear,
            cond = require("helpers.cmake-tools").is_cmake_project,
            on_click = function(n, mouse)
              if n == 1 then
                if mouse == "l" then
                  require("helpers.cmake-tools").build()
                end
              end
            end,
          },
          {
            function()
              local b_preset = require("cmake-tools").get_build_preset()
              return "[" .. (b_preset and b_preset or "X") .. "]"
            end,
            separator = "",
            cond = function()
              return require("helpers.cmake-tools").is_cmake_project() and require("cmake-tools").has_cmake_preset()
            end,
            on_click = function(n, mouse)
              if n == 1 then
                if mouse == "l" then
                  require("helpers.cmake-tools").select_build_preset()
                end
              end
            end,
          },
          {
            function()
              local b_target = require("cmake-tools").get_build_target()
              return "[" .. (b_target and b_target or "X") .. "]"
            end,
            cond = require("helpers.cmake-tools").is_cmake_project,
            on_click = function(n, mouse)
              if n == 1 then
                if mouse == "l" then
                  require("helpers.cmake-tools").select_build_target()
                end
              end
            end,
          },
          {
            function()
              return " " .. vscode_icons.ui.Run .. " "
            end,
            padding = { left = 1, right = 0 },
            separator = "|",
            cond = require("helpers.cmake-tools").is_cmake_project,
            on_click = function(n, mouse)
              if n == 1 then
                if mouse == "l" then
                  require("helpers.cmake-tools").debug()
                end
              end
            end,
          },
          {
            function()
              return " " .. vscode_icons.ui.Bug .. " "
            end,
            padding = { left = 0, right = 0 },
            separator = "|",
            cond = require("helpers.cmake-tools").is_cmake_project,
            on_click = function(n, mouse)
              if n == 1 then
                if mouse == "l" then
                  require("helpers.cmake-tools").debug()
                end
              end
            end,
          },
          {
            function()
              return " " .. vscode_icons.ui.Close .. " "
            end,
            padding = { left = 0, right = 0 },
            separator = "",
            cond = require("helpers.cmake-tools").is_cmake_project,
            on_click = function(n, mouse)
              if n == 1 then
                if mouse == "l" then
                  require("helpers.dap").close_debug_session()
                end
              end
            end,
          },
          {
            function()
              local l_target = require("cmake-tools").get_launch_target()
              return "[" .. (l_target and l_target or "X") .. "]"
            end,
            cond = require("helpers.cmake-tools").is_cmake_project,
            on_click = function(n, mouse)
              if n == 1 then
                if mouse == "l" then
                  require("helpers.cmake-tools").select_launch_target()
                end
              end
            end,
          },
        },
      },
    }
  end,
}
