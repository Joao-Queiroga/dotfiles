local handlers = require("plugins.lsp.handlers")
local installed_servers = {
	"lua_ls",
	"rust_analyzer",
	"clangd",
	"gopls",
	"emmet_language_server",
	"tsserver",
	"cssls",
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
		keys = {
			{ "<leader>lt", "<cmd>TroubleToggle<cr>", mode = { "n", "v", "x" }, desc = "Trouble" },
			{
				"<leader>lw",
				"<cmd>TroubleToggle workspace_diagnostics<cr>",
				mode = { "n", "v", "x" },
				desc = "Workspace Diagnostics",
			},
			{
				"<leader>ld",
				"<cmd>TroubleToggle document_diagnostics<cr>",
				mode = { "n", "v", "x" },
				desc = "Document Diagnostics",
			},
			{ "<leader>lq", "<cmd>roubleToggle quickfix<cr>", mode = { "n", "v", "x" }, desc = "Quickfixes" },
			{ "<leader>ll", "<cmd>roubleToggle loclist<cr>", mode = { "n", "v", "x" }, desc = "Loclist" },
			{ "<leader>lR", "<cmd>roubleToggle lsp_references<cr>", mode = { "n", "v", "x" }, desc = "LSP References" },
		},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = { "Trouble", "TroubleToggle" },
		opts = {},
	},
	{ import = "plugins.lsp.navic" },
	{ import = "plugins.lsp.language-specifics" },
}
