---@type LazySpec[]
return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
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
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
  },
  {
    "Bekaboo/dropbar.nvim",
    lazy = false,
    keys = {
      {
        "<leader>lo",
        function()
          require("dropbar.api").pick()
        end,
        desc = "Pick symbols in winbar",
      },
    },
    ---@type dropbar_configs_t
    opts = {
      icons = {
        kinds = vim.g.kind_icons,
        ui = {
          bar = {
            separator = " › ",
          },
          menu = {
            separator = " › ",
          },
        },
      },
    },
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {
      input = {
        insert_only = false,
        start_in_insert = false,
      },
      select = {
        backend = { "builtin", "nui" },
      },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
    opts = {
      spec = {
        { "<leader>g", group = "Git" },
        { "<leader>y", group = "Chezmoi" },
        { "<leader>f", group = "Find/File" },
        { "<leader>s", group = "Search" },
        { "<leader>q", hidden = true },
        { "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
      },
    },
  },
}
