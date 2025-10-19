---@type PluginList
return {
  {
    "mini.nvim",
    lazy = false,
    keys = {
      {
        "<leader>c",
        function()
          require("mini.bufremove").delete()
        end,
      },
      {
        "<leader>fm",
        function()
          require("mini.files").open()
        end,
        desc = "File Browser",
        mode = { "n", "v" },
      },
    },
    beforeAll = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
    after = function()
      require("mini.files").setup({
        windows = {
          preview = true,
          width_preview = 40,
        },
      })
      require("mini.icons").setup()
    end,
  },
  {
    "mini.surround",
    keys = {
      { "gsa", desc = "Add surrounding", mode = { "n", "v" } },
      { "gsd", desc = "Delete surrounding", mode = { "n", "v" } },
      { "gsf", desc = "Find surrounding (to the right)" },
      { "gsF", desc = "Find surrounding (to the left)" },
      { "gsh", desc = "Highlight surrounding", mode = { "n", "v" } },
      { "gsr", desc = "Replace surrounding", mode = { "n", "v" } },
      { "gsn", desc = "Update `n_lines`", mode = { "n", "v" } },
    },
    after = function()
      require("mini.surround").setup({
        mappings = {
          add = "gsa",
          delete = "gsd",
          find = "gsf",
          find_left = "gsF",
          highlight = "gsh",
          replace = "gsr",
          update_n_lines = "gsn",
        },
      })
    end,
  },
  {
    "mini.move",
    keys = {
      { "<M-h>", mode = { "n", "v" } },
      { "<M-j>", mode = { "n", "v" } },
      { "<M-k>", mode = { "n", "v" } },
      { "<M-l>", mode = { "n", "v" } },
    },
    after = function()
      require("mini.move").setup()
    end,
  },
  {
    "mini.align",
    keys = {
      { "ga", mode = { "n", "v" } },
      { "gA", mode = { "n", "v" } },
    },
    after = function()
      require("mini.align").setup({
        mappings = {
          start_with_preview = "ga",
          start = "gA",
        },
      })
    end,
  },
}
