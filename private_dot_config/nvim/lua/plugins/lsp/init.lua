local handlers = require'plugins.lsp.handlers'
local installed_servers = {
	'lua_ls',
	'rust_analyzer',
	'clangd',
	'gopls',
	'jdtls',
	'vimls',
	'jsonls',
	'yamlls',
	'rnix',
	'nil_ls'
}
return {
	{
		'neovim/nvim-lspconfig',
		config = handlers.setup
	},
	{
		'williamboman/mason-lspconfig.nvim',
		dependencies = {
			'williamboman/mason.nvim',
			'folke/neoconf.nvim',
			'neovim/nvim-lspconfig',
		},
		opts = {
			ensure_installed = installed_servers,
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
