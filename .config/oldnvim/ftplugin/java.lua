local config = {
  cmd = {
    vim.fn.exepath("jdtls"),
    string.format("--jvm-arg=-javaagent:%s", vim.fn.expand("$MASON/share/jdtls/lombok.jar")),
  },

  settings = {
    java = {
      inlayHints = {
        parameterNames = {
          enabled = "all",
        },
      },
    },
  },
}

require("jdtls").start_or_attach(config)
