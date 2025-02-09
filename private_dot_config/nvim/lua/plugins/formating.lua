local slow_format_filetypes = { "java" }

---@type LazySpec[]
return {
  {
    "stevearc/conform.nvim",
    dependencies = { "williamboman/mason.nvim" },
    event = "BufWritePre",
    cmd = "ConformInfo",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        json = { "prettierd" },
        html = { "prettierd" },
        css = { "prettierd" },
        scss = { "prettierd" },
        sass = { "prettierd" },
        rust = { "rustfmt" },
        nix = { "nixfmt" },
        c = { "clang-format" },
        go = { "gofmt" },
        cpp = { "clang-format" },
        java = { "google-java-format" },
        toml = { "taplo" },
      },
      format_on_save = {
        timeout_ms = 3000,
        async = false,
        quiet = false,
        lsp_format = "fallback",
      },
    },
  },
  {
    "zapling/mason-conform.nvim",
    event = "VeryLazy",
    dependencies = { "stevearc/conform.nvim" },
    opts = {},
  },
}
