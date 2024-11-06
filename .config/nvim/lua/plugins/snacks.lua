---@type LazySpec
return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {},
	keys = {
		{
			"<leader>c",
			function()
				Snacks.bufdelete()
			end,
			desc = "Delete Buffer",
		},
		{
			"<leader>gg",
			function()
				Snacks.lazygit()
			end,
			desc = "Lazygit",
		},
		{
			"<leader>yl",
			function()
				local original_env = {
					GIT_DIR = vim.env.GIT_DIR,
					WORK_TREE = vim.env.WORK_TREE,
				}
				vim.env.GIT_DIR = vim.fn.expand("~/.local/share/yadm/repo.git")
				vim.env.WORK_TREE = os.getenv("HOME")
				vim.cmd([[LazyGit]])
				vim.env.GIT_DIR = original_env.GIT_DIR
				vim.env.WORK_TREE = original_env.WORK_TREE
			end,
			desc = "Lazygit",
		},
	},
}
