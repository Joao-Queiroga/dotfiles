---@type lze.PluginSpec[]
return {
  {
    "lualine.nvim",
    event = "DeferredUIEnter",
    after = function()
      require("lualine").setup()
    end,
  },
  {
    "noice.nvim",
    event = "DeferredUIEnter",
    after = function()
      require("noice").setup({
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        presets = {
          bottom_search = true,
          command_palette = true,
          long_message_to_split = true,
        },
      })
    end,
  },
  {
    "bufferline.nvim",
    event = "DeferredUIEnter",
    after = function()
      require("bufferline").setup({
        options = {
          diagnostics = "nvim_lsp",
          diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
          end,
        },
      })
    end,
  },
}
