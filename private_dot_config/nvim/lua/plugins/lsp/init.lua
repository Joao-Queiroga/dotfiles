local handlers = require'plugins.lsp.handlers'
local ensure_instaled = {
	'lua_language_server',
	'vim-language-server',
	'jdtls',
	'rust-analyzer'
}
return {
	{
		'neovim/nvim-lspconfig',
		config = handlers.setup
	},
	{
		'williamboman/mason.nvim',
		lazy = true,
		opts = {
			ui = {
				icons = {
					package_pending = " ",
					package_installed = "󰄳 ",
					package_uninstalled = " 󰚌",
				}
			}
		},
	},
	{
		'williamboman/mason-lspconfig.nvim',
		dependencies = {
			'williamboman/mason.nvim',
			'folke/neoconf.nvim',
			'neovim/nvim-lspconfig',
		},
		opts = {
			ensure_instaled = ensure_instaled,
			handlers = { handlers.choose_handler }
		}
	},
	{
		'folke/neoconf.nvim',
		opts = {},
	},
	{
		"smjonas/inc-rename.nvim",
		cmd = "IncRename",
		config = true
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = { "Trouble", "TroubleToggle" },
		opts = {},
	},
	{
		'nvimdev/lspsaga.nvim',
		event = "LspAttach",
		dependencies = {
			'nvim-treesitter/nvim-treesitter',
			'nvim-tree/nvim-web-devicons'
		},
		opts = {
			outline = {
				layout = 'float',
				keys = {
					toggle_or_jump = '<Tab>',
					jump = 'l',
				}
			}
		}
	},
	{
		'folke/neodev.nvim',
		lazy = true
	},
	{
		'mfussenegger/nvim-jdtls',
		lazy = true
	},
	{
		'simrat39/rust-tools.nvim',
		lazy = true
	},
}
