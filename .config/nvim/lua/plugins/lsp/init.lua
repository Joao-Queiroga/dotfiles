local handlers = require("plugins.lsp.handlers")
local installed_servers = {
	"lua_ls",
	"rust_analyzer",
	"clangd",
	"gopls",
	"jdtls",
	"vimls",
	"jsonls",
	"yamlls",
	"rnix",
	"nil_ls",
}
return {
	{
		"neovim/nvim-lspconfig",
		config = handlers.setup,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"folke/neoconf.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {
			ensure_installed = installed_servers,
			handlers = { handlers.choose_handler },
		},
	},
	{
		"RRethy/vim-illuminate",
		event = "VeryLazy",
		opts = {},
		config = function(_, opts)
			require("illuminate").configure(opts)
		end,
	},
	{
		"folke/neoconf.nvim",
		opts = {},
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = { "Trouble", "TroubleToggle" },
		opts = {},
	},
	{ import = "plugins.lsp.navic" },
	{
		"folke/neodev.nvim",
		lazy = true,
	},
	{
		"mfussenegger/nvim-jdtls",
		lazy = true,
	},
	{
		"saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvimtools/none-ls.nvim",
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
	{
		"justinsgithub/wezterm-types",
		lazy = true,
	},
}
