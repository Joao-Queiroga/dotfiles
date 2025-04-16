local handlers = require("lsp")

---@type LazySpec[]
return {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        "lazy.nvim",
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true },
  { "justinsgithub/wezterm-types", lazy = true },
  {
    "pmizio/typescript-tools.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {
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
    version = "^6",
    opts = {},
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
        actions = true,
        completion = true,
        hover = true,
      },
    },
  },
}
