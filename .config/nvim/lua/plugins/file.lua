return {
	{
		"echasnovski/mini.files",
		opts = {
			windows = {
				preview = true,
				width_preview = 40,
			},
		},
	},
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		opts = require("plugins.config.nvim-tree"),
		enabled = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		cmd = "Neotree",
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
					enabled = true
				}
			}
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
