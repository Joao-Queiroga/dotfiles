---@type PluginList
return {
  {
    "nui.nvim",
    on_plugin = { "noice.nvim" },
  },
  {
    "plenary.nvim",
    on_require = {
      "plenary.async",
      "plenary.async_lib",
      "plenary.job",
      "plenary.path",
      "plenary.scandir",
      "plenary.context_manager",
      "plenary.test_harness",
      "plenary.filetype",
      "plenary.strings",
    },
  },
}
