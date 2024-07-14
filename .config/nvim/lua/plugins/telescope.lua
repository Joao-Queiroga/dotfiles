local function extension(ext)
	return function()
		return require("telescope").load_extension(ext)
	end
end
return {
	{
		"nvim-telescope/telescope.nvim",
		keys = {
			{ "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Find Text" },
			{ "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Recent files" },
			-- { "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
			{ "<leader><space>", "<cmd>Telescope find_files<cr>", desc = "Find files" },
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
			{ "<leader>fr", "<cmd>Telescope buffers<cr>", desc = "Recent files" },
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				config = extension("fzf"),
			},
		},
		opts = {
			defaults = {
				prompt_prefix = " ",
				selection_caret = " ",
				path_display = { "smart" },
				initial_mode = "normal",
			},
			pickers = {
				find_files = {
					theme = "dropdown",
					previewer = false,
				},
				oldfiles = {
					theme = "dropdown",
					previewer = false,
				},
			},
		},
	},
}
