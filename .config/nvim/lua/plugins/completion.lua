---@type LazySpec[]
return {
  {
    "saghen/blink.cmp",
    lazy = false,
    dependencies = "rafamadriz/friendly-snippets",

    -- use a release tag to download pre-built binaries
    version = "v0.*",

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        presets = "enter",
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        ["<C-e>"] = { "hide", "fallback" },
        ["<C-E>"] = { "hide_documentation", "fallback" },
        ["<C-j>"] = { "scroll_documentation_down", "fallback" },
        ["<C-k>"] = { "scroll_documentation_up", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
      },
      windows = {
        documentation = { auto_show = true },
      },
      -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- adjusts spacing to ensure icons are aligned
      nerd_font_variant = "normal",

      -- experimental auto-brackets support
      accept = { auto_brackets = { enabled = true } },

      -- experimental signature help support
      trigger = { signature_help = { enabled = true } },
      kind_icons = vim.g.kind_icons,
    },
  },
}
