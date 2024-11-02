---@type LazySpec[]
return {
	{
		"kdheepak/lazygit.nvim",
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		keys = {
			{ "<leader>gg", "<cmd>LazyGit<cr>", desc = "Lazygit" },
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
				desc = "Lazygit yadm",
			},
		},
	},
	{
		"purarue/gitsigns-yadm.nvim",
		lazy = true,
		dependencies = {
			"lewis6991/gitsigns.nvim",
			opts = {
				_on_attach_pre = function(_, callback)
					require("gitsigns-yadm").yadm_signs(callback)
				end,
			},
		},
		enabled = vim.fn.executable("yadm") == 1,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "󰐊" },
				topdelete = { text = "󰐊" },
				changedelete = { text = "▎" },
			},
		},
	},
}
