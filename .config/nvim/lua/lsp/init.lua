local M = {}

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

local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

local config = {
  virtual_text = true,
  signs = {
    active = signs,
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
}

vim.lsp.inlay_hint.enable()

vim.diagnostic.config(config)

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("my.lsp", {}),
  callback = function(args)
    lsp_keymaps(args.buf)
  end,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

function M.default_handler(server_name) -- default handler
  vim.lsp.enable(server_name)
end

-- check if there is a custom handler if there is, use it, if not use the default one
function M.choose_handler(server_name)
  local handler_ok, _ = pcall(require, "lsp.custom_handlers." .. server_name)
  if not handler_ok then
    M.default_handler(server_name)
  end
end

return M
