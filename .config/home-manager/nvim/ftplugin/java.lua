local config = {
  cmd = { "jdtls" },

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
