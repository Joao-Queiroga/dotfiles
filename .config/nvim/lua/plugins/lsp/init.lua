local handlers = require("plugins.lsp.handlers")
local installed_servers = {
	"lua_ls",
	"rust_analyzer",
	"clangd",
	"gopls",
	"emmet_language_server",
	"ts_ls",
	"cssls",
	"vimls",
	"jsonls",
	"yamlls",
	"rnix",
	"nil_ls",
}
---@type LazySpec[]
return {
	{
		"neovim/nvim-lspconfig",
		keys = { { "<leader>l", "", desc = "LSP", mode = { "n", "v", "x" } } },
		lazy = false,
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
		"kosayoda/nvim-lightbulb",
		event = "LspAttach",
		opts = {
			autocmd = {
				enabled = true,
			},
		},
	},
	{
		"folke/trouble.nvim",
		keys = {
			{
				"<leader>ld",
				"<cmd>Trouble diagnostics toggle<cr>",
				mode = { "n", "v", "x" },
				desc = "Document Diagnostics",
			},
			{ "<leader>lq", "<cmd>Trouble quickfix toggle<cr>", mode = { "n", "v", "x" }, desc = "Quickfixes" },
			{ "<leader>ll", "<cmd>Trouble loclist toggle<cr>", mode = { "n", "v", "x" }, desc = "Loclist" },
			{
				"<leader>lR",
				"<cmd>Trouble lsp_references toggle<cr>",
				mode = { "n", "v", "x" },
				desc = "LSP References",
			},
		},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = "Trouble",
		opts = {},
	},
	{ import = "plugins.lsp.navic" },
	{ import = "plugins.lsp.language-specifics" },
}
