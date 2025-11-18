---@type PluginList
return {
  {
    "lazydev.nvim",
    ft = "lua",
    after = function()
      require("lazydev").setup()
    end,
    on_require = { "lazydev" },
  },
  {
    "typescript-tools.nvim",
    after = function()
      require("typescript-tools").setup({
        settings = {
          expose_as_code_action = "all",
          tsserver_locale = "pt-br",
          tsserver_file_preferences = {
            importModuleSpecifierPreference = "shortest",
          },
        },
      })
    end,
  },
  {
    "rustaceanvim",
    before = function()
      vim.g.rustaceanvim = {
        server = {
          default_settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                buildScripts = {
                  enable = true,
                },
              },
              checkOnSave = true,
            },
          },
        },
      }
    end,
  },
  {
    "crates.nvim",
    event = { "BufRead Cargo.toml" },
    after = function()
      require("crates").setup({
        lsp = {
          enabled = true,
          actions = true,
          completion = true,
          hover = true,
        },
      })
    end,
  },
  {
    "nvim-jdtls",
    on_require = "jdtls",
  },
  {
    "spring-boot.nvim",
    on_require = "spring_boot",
  },
}
