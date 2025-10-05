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
  {
    "which-key.nvim",
    event = "DeferredUIEnter",
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
    after = function()
      require("which-key").setup({
        spec = {
          { "<leader>g", group = "Git" },
          { "<leader>y", group = "Yadm" },
          { "<leader>f", group = "Find/File" },
          { "<leader>s", group = "Search" },
          { "<leader>q", hidden = true },
          { "<leader>l", group = "lsp" },
          { "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
        },
      })
    end,
  },
}
