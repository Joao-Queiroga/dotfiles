local slow_format_filetypes = { "java" }

return {
	{
		"stevearc/conform.nvim",
		dependencies = { "williamboman/mason.nvim", "mason-tool-installer.nvim" },
		event = "BufWritePre",
		cmd = "ConformInfo",
		opts = {
			format_on_save = function(bufnr)
				if slow_format_filetypes[vim.bo[bufnr].filetype] then
					return
				end
				local function on_format(err)
					if err and err:match("timeout$") then
						slow_format_filetypes[vim.bo[bufnr].filetype] = true
					end
				end

				return { timeout_ms = 200, lsp_fallback = true }, on_format
			end,
			format_after_save = function(bufnr)
				if not slow_format_filetypes[vim.bo[bufnr].filetype] then
					return
				end
				return { lsp_fallback = true }
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				javascript = { { "prettierd", "prettier" } },
				typescript = { { "prettierd", "prettier" } },
				json = { { "prettierd", "prettier" } },
				html = { { "prettierd", "prettier" } },
				css = { { "prettierd", "prettier" } },
				scss = { { "prettierd", "prettier" } },
				sass = { { "prettierd", "prettier" } },
				rust = { "rustfmt" },
				nix = { "nixfmt" },
				c = { "clang-format" },
				go = { "gofmt" },
				cpp = { "clang-format" },
				java = { "google-java-format" },
			},
		},
	},
}
