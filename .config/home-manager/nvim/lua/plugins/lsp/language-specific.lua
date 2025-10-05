---@type lze.PluginSpec[]
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
          jsx_close_tag = {
            enabled = true,
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
    'nvim-jdtls',
    lazy = true,
    on_require = "jdtls",
  }
}
