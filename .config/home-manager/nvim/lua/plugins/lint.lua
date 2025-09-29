---@type lze.PluginSpec[]
return {
  {
    "nvim-lint",
    event = { "BufWrite", "BufRead", "InsertLeave" },
    after = function(plug)
      local events = { "BufWritePost", "BufReadPost", "InsertLeave" }
      local lint = require('lint')
      lint.linters_by_ft = {
        fish = { "fish" },
        python = { "flake8" },
        lua = { "selene" },
        java = { "checkstyle" },
        rust = { "clippy" },
      }
      vim.api.nvim_create_autocmd(events, {
        callback = function()
          lint.try_lint()
        end,
      })
    end
  }
}
