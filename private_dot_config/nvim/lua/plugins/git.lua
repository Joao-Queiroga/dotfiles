return {
	{
		"NeogitOrg/neogit",
		cmd = "Neogit",
		dependencies = "nvim-lua/plenary.nvim",
		opts = {},
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
