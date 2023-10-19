local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
return {
	{
		"nvimtools/none-ls.nvim",
		main = "null-ls",
		event = "VeryLazy",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"mason.nvim",
		},
		opts = function()
			local nls = require("null-ls")
			return {
				root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
				sources = {
					nls.builtins.formatting.stylua,
					nls.builtins.diagnostics.clang_check,
					nls.builtins.diagnostics.flake8,
					nls.builtins.diagnostics.zsh,
				},
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({ async = false })
							end,
						})
					end
				end,
			}
		end,
	},
}
