local config = {
  cmd = { "jdtls" },
  init_options = { bundles = {} },

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

vim.list_extend(config.init_options.bundles, require("spring_boot").java_extensions(require("nixCats").cats.springJars))

require("jdtls").start_or_attach(config)
