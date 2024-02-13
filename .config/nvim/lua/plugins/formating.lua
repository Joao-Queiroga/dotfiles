return {
	{
		"stevearc/conform.nvim",
		dependencies = { "williamboman/mason.nvim", "mason-tool-installer.nvim" },
		event = "BufWritePre",
		cmd = "ConformInfo",
		opts = {
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
				cpp = { "clang-format" },
				java = { "clang-format" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
		},
	},
}
