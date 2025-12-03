---@module 'lze'
---@alias PluginSpec lze.PluginSpec
---@alias SpecImport lze.SpecImport
---@alias PluginList (PluginSpec | SpecImport)[] | PluginSpec
---@type PluginList
require("lze").load({
  { import = "plugins.lsp" },
  { import = "plugins.completion" },
  { import = "plugins.editor" },
  { import = "plugins.formating" },
  { import = "plugins.lint" },
  { import = "plugins.utils" },
  { import = "plugins.heirline" },
  { import = "plugins.ui" },
  { import = "plugins.mini" },
  { import = "plugins.snacks" },
  { import = "plugins.treesitter" },
  { import = "plugins.lib" },
})
