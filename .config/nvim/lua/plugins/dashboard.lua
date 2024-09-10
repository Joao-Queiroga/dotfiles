---@type LazySpec[]
return {
	"nvimdev/dashboard-nvim",
	lazy = false,
	opts = {
		theme = "doom",
		config = {
			week_header = {
				enable = true,
			},
			center = {
				{
					action = "Telescope find_files",
					desc = " Find File",
					icon = " ",
					key = "f",
				},
				{
					action = "ene | startinsert",
					desc = " New File",
					icon = " ",
					key = "n",
				},
				{
					action = "Telescope oldfiles",
					desc = " Recent Files",
					icon = " ",
					key = "r",
				},
				{
					action = "Telescope live_grep",
					desc = " Find Text",
					icon = " ",
					key = "g",
				},
				{
					action = "e " .. vim.fn.stdpath("config") .. "/init.lua",
					desc = " Config",
					icon = " ",
					key = "c",
				},
				{
					action = 'lua require("persistence").load()',
					desc = " Restore Session",
					icon = " ",
					key = "s",
				},
				{
					action = "Lazy",
					desc = " Lazy",
					icon = "󰒲 ",
					key = "l",
				},
				{
					action = function()
						vim.api.nvim_input("<cmd>qa<cr>")
					end,
					desc = " Quit",
					icon = " ",
					key = "q",
				},
			},
		},
	},
}
