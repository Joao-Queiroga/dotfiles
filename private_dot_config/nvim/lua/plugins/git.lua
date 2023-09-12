return {
	{
		"NeogitOrg/neogit",
		cmd =  "Neogit",
		dependencies = "nvim-lua/plenary.nvim",
		opts = {}
	},
	{
		'lewis6991/gitsigns.nvim',
		event = "VeryLazy",
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "󰐊" },
				topdelete = { text = "󰐊" },
				changedelete = { text = "▎" },
			},
			yadm = {
				enable = false,
			}
		}
	},
	{
		'kdheepak/lazygit.nvim',
		dependencies = 'nvim-lua/plenary.nvim',
		cmd = "LazyGit",
		enabled = vim.fn.executable('lazygit')
	},
}
