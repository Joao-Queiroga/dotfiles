local handlers = require("plugins.lsp.handlers")

return {
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				"lazy.nvim",
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true },
	{ "justinsgithub/wezterm-types", lazy = true },
	{
		"nvim-java/nvim-java",
		lazy = true,
		opts = {
			jdk = {
				auto_install = false,
			},
		},
	},
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		lazy = true,
		opts = {
			on_attach = handlers.on_attach,
		},
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^3",
		ft = { "rust" },
		opts = {
			server = handlers.get_opts("rust_analyzer"),
		},
		config = function(_, opts)
			vim.g.rustaceanvim = opts
		end,
	},
	{
		"saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		init = function()
			vim.api.nvim_create_autocmd("BufRead", {
				group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
				pattern = "Cargo.toml",
				callback = function()
					require("cmp").setup.buffer({ sources = { { name = "crates" } } })
				end,
			})
		end,
		opts = {
			src = {
				cmp = {
					enabled = true,
				},
			},
		},
	},
}
