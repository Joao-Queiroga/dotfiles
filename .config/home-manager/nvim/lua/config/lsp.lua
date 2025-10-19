local function lsp_keymaps(buf)
  local function opts(desc)
    return { noremap = true, silent = true, buffer = buf, desc = desc }
  end
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts())
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts())
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts())
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts())
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts())
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts())
  vim.keymap.set("n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts())
  vim.keymap.set("n", "gl", '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = "rounded" })<CR>', opts())
  vim.keymap.set("n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts())
  vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts())
  vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts("Code Actions"))
  vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts("Rename"))
end

vim.lsp.inlay_hint.enable()

vim.diagnostic.config({
  virtual_text = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = " ",
    },
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    header = "",
    prefix = "",
  },
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("my.lsp", {}),
  callback = function(args)
    lsp_keymaps(args.buf)
  end,
})
