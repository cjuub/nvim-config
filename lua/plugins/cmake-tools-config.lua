return {
  {
    "cjuub/cmake-tools.nvim",
    branch = "remove-dap-dependency",
    opts = {
      cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
      cmake_build_options = { "-j32" },
      cmake_soft_link_compile_commands = true,
      cmake_dap_configuration = { -- debug settings for cmake
        name = "cpp",
        type = "cppdbg",
        request = "launch",
        stopOnEntry = false,
        runInTerminal = true,
        console = "integratedTerminal",
      },
    },
  },
}
