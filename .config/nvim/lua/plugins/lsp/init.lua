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
	{
		"folke/neodev.nvim",
		lazy = true,
	},
	{
		"nvim-java/nvim-java",
		dependencies = {
			"nvim-java/lua-async-await",
			"nvim-java/nvim-java-refactor",
			"nvim-java/nvim-java-core",
			"nvim-java/nvim-java-test",
			"nvim-java/nvim-java-dap",
			"MunifTanjim/nui.nvim",
			"neovim/nvim-lspconfig",
			"mfussenegger/nvim-dap",
			{
				"williamboman/mason.nvim",
				opts = {
					registries = {
						"github:nvim-java/mason-registry",
						"github:mason-org/mason-registry",
					},
				},
			},
		},
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
	{
		"justinsgithub/wezterm-types",
		lazy = true,
	},
}
