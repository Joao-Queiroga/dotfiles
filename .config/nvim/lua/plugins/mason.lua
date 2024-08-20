--[[ local ensure_installed = {
	"prettierd",
	"clang-format",
	"google-java-format",
	"checkstyle",
	"flake8",
	"luacheck",
	"stylua",
	"black",
	"isort",
} ]]
return {
	{
		"williamboman/mason.nvim",
		lazy = true,
		cmd = "Mason",
		build = ":MasonUpdate",
		opts = {
			ui = {
				icons = {
					package_pending = " ",
					package_installed = "󰄳 ",
					package_uninstalled = " 󰚌",
				},
			},
		},
	},
	-- {
	-- 	"WhoIsSethDaniel/mason-tool-installer.nvim",
	-- 	lazy = true,
	-- 	dependencies = { "williamboman/mason.nvim" },
	-- 	opts = {
	-- 		ensure_installed = ensure_installed,
	-- 	},
	-- },
}
