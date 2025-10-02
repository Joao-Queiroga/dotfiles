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
              checkOnSave = false,
              diagnostics = { enable = false },
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
