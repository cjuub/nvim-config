return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  lazy = false,
  build = ":Copilot auth",
  opts = {
    panel = { enabled = false },
    suggestion = {
      enabled = true,
      auto_trigger = true,
      keymap = {
        accept = "<M-Tab>",
        accept_word = false,
        accept_line = false,
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<M-p>",
      },
    },
    filetypes = {
      markdown = true,
      help = true,
    },
  },
}
