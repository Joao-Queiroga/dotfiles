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
		"folke/neoconf.nvim",
		opts = {},
	},
	{
		"smjonas/inc-rename.nvim",
		cmd = "IncRename",
		config = true,
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = { "Trouble", "TroubleToggle" },
		opts = {},
	},
	{ import = "plugins.lsp.navic" },
	{
		"nvimdev/lspsaga.nvim",
		event = "LspAttach",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		enabled = false,
		opts = {
			outline = {
				layout = "float",
				keys = {
					toggle_or_jump = "<Tab>",
					jump = "l",
				},
			},
		},
	},
	{
		"folke/neodev.nvim",
		lazy = true,
	},
	{
		"mfussenegger/nvim-jdtls",
		lazy = true,
	},
	{
		"simrat39/rust-tools.nvim",
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
			null_ls = {
				enabled = true,
				name = "crates.nvim",
			},
		},
	},
}
