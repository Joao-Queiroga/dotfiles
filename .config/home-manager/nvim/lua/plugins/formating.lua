---@type PluginList
return {
  {
    "conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    after = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "ruff_format" },
          javascript = { "prettierd" },
          javascriptreact = { "prettierd" },
          typescript = { "prettierd" },
          typescriptreact = { "prettierd" },
          json = { "prettierd" },
          html = { "prettierd" },
          css = { "prettierd" },
          scss = { "prettierd" },
          qml = { "qmlformat" },
          sass = { "prettierd" },
          rust = { "rustfmt" },
          nix = { "alejandra" },
          c = { "clang-format" },
          go = { "gofmt" },
          cpp = { "clang-format" },
          java = { "google-java-format" },
          toml = { "taplo" },
          ["_"] = { "trim_whitespace", "trim_newlines" },
        },
        format_on_save = {
          timeout_ms = 3000,
          async = false,
          quiet = false,
          lsp_format = "fallback",
        },
      })
    end,
  },
}
