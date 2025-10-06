---@type PluginList
return {
  {
    "nvim-lint",
    event = { "BufWrite", "BufRead", "InsertLeave" },
    after = function()
      local events = { "BufWritePost", "BufReadPost", "InsertLeave" }
      local lint = require("lint")
      lint.linters_by_ft = {
        fish = { "fish" },
        python = { "ruff" },
        lua = { "selene" },
        java = { "checkstyle" },
        rust = { "clippy" },
      }
      vim.api.nvim_create_autocmd(events, {
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
