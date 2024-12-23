---@type LazySpec[]
return {
  {
    "saghen/blink.cmp",
    lazy = false,
    dependencies = "rafamadriz/friendly-snippets",
    version = "*",

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = "enter",
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        ["<C-e>"] = { "hide", "fallback" },
        ["<C-E>"] = { "hide_documentation", "fallback" },
        ["<C-j>"] = { "scroll_documentation_down", "fallback" },
        ["<C-k>"] = { "scroll_documentation_up", "fallback" },
      },
      signature = { enabled = true },
      appearance = {
        nerd_font_variant = "normal",
        kind_icons = vim.g.kind_icons,
      },
      completion = {
        list = {
          selection = "manual",
        },
      },
    },
  },
}
