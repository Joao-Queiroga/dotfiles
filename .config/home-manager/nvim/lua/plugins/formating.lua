---@type lze.PluginSpec[]
return {
  {
    'conform.nvim',
    event = "BufWritePre",
    cmd = "ConformInfo",
    after = function()
      require('conform').setup({
        formaters_by_ft = {
          lua = { 'stylua' }
        },
        format_on_save = {
          timeout_ms = 3000,
          async = false,
          quiet = false,
          lsp_format = "fallback",
        },
      })
    end
  }
}
