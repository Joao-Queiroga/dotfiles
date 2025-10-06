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
      require("mini.align").setup({
        mappings = {
          start_with_preview = "ga",
          start = "gA",
        },
      })
      require("mini.files").setup({
        windows = {
          preview = true,
          width_preview = 40,
        },
      })
      require("mini.move").setup()
      require("mini.icons").setup()
    end,
  },
}
