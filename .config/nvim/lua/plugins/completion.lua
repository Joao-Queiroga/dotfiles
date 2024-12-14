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
      windows = {
        documentation = { auto_show = true },
      },
      -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- adjusts spacing to ensure icons are aligned
      nerd_font_variant = "normal",

      -- experimental auto-brackets support
      accept = { auto_brackets = { enabled = true } },
      ghost_text = { enabled = true },

      -- experimental signature help support
      trigger = { signature_help = { enabled = true } },
      kind_icons = vim.g.kind_icons,
    },
  },
}
