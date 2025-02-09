local handlers = require("plugins.lsp.handlers")

---@type LazySpec[]
return {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        "lazy.nvim",
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true },
  { "justinsgithub/wezterm-types", lazy = true },
  {
    "pmizio/typescript-tools.nvim",
    lazy = true,
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {
      on_attach = handlers.on_attach,
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
    },
  },
  {
    "nvim-java/nvim-java",
    lazy = true,
    opts = {
      jdk = {
        auto_install = false,
      },
    },
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    opts = {
      server = handlers.get_opts("rust_analyzer"),
    },
    config = function(_, opts)
      vim.g.rustaceanvim = opts
    end,
  },
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      lsp = {
        enabled = true,
        on_attach = handlers.on_attach,
        actions = true,
        completion = true,
        hover = true,
      },
    },
  },
}
