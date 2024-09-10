---@type LazySpec[]
return {
	{
		"echasnovski/mini.files",
		keys = {
			{ "<leader>fm", "<cmd>lua MiniFiles.open()<cr>", desc = "File Browser", mode = { "n", "v" } },
		},
		lazy = false,
		opts = {
			windows = {
				preview = true,
				width_preview = 40,
			},
		},
	},
	{
		"mikavilpas/yazi.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		event = "VeryLazy",
		enabled = vim.fn.executable("yazi") == 1,
		keys = {
			{
				"<leader>fM",
				function()
					require("yazi").yazi()
				end,
				desc = "Open the file manager",
			},
		},
		---@type YaziConfig
		opts = {
			open_for_directories = false,
		},
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		cmd = "Neotree",
		keys = {
			{ "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle FileTree", mode = { "n", "v" } },
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"s1n7ax/nvim-window-picker",
			"MunifTanjim/nui.nvim",
		},
		opts = {
			window = {
				width = 30,
				mappings = {
					["l"] = "open_with_window_picker",
					["h"] = "close_node",
					["C"] = "close_all_nodes",
					["<C-x>"] = "split_with_window_picker",
					["<C-v>"] = "vsplit_with_window_picker",
				},
			},
			filesystem = {
				use_libuv_file_watcher = true,
				follow_current_file = {
					enabled = true,
				},
				filtered_items = {
					hide_by_name = {
						"node_modules",
						"types",
						"tsconfig.json",
						"package-lock.json",
					},
				},
			},
			event_handlers = {
				{
					event = "file_added",
					handler = function(file_path)
						if string.find(file_path, vim.fn.expand("~/.config/nvim/")) then
							os.execute("yadm add " .. file_path)
						end
					end,
				},
				{
					event = "file_renamed",
					handler = function(args)
						if string.find(args.destination, vim.fn.expand("~/.config/nvim/")) then
							os.execute("yadm add " .. args.destination)
						end
					end,
				},
			},
		},
	},
	{
		"s1n7ax/nvim-window-picker",
		lazy = true,
		version = "2.*",
		opts = {
			filter_rules = {
				bo = {
					-- if the file type is one of following, the window will be ignored
					filetype = { "neo-tree", "neo-tree-popup", "notify", "NvimTree", "noice" },

					-- if the file type is one of following, the window will be ignored
					buftype = { "terminal", "quickfix", "nofile" },
				},
				other_win_hl_color = "#4493C8",
			},
		},
	},
}
