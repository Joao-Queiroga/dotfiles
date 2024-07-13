return {
	{
		"Joao-Queiroga/lazygit-nvim",
		cmd = "LazyGit",
		keys = {
			{ "<leader>gl", "<cmd>LazyGit<cr>", desc = "Lazygit" },
			{ "<leader>yl", "<cmd>LazyGit<cr>", desc = "Lazygit yadm" },
		},
	},
	{
		"seanbreckenridge/gitsigns-yadm.nvim",
		lazy = true,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		opts = {
			_on_attach_pre = function(_, callback)
				require("gitsigns-yadm").yadm_signs(callback)
			end,
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
