return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {
			options = {
				theme = "tokyonight",
				component_separators = { left = "|", right = "|" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {
						"help",
						"startify",
						"dashboard",
						"packer",
						"neogitstatus",
						"NvimTree",
						"Trouble",
						"alpha",
						"lir",
						"Outline",
						"spectre_panel",
						"toggleterm",
						"neo-tree",
						"neo-tree-popup",
						"notify",
					},
					winbar = {
						"help",
						"startify",
						"dashboard",
						"packer",
						"neogitstatus",
						"NvimTree",
						"Trouble",
						"alpha",
						"lir",
						"Outline",
						"spectre_panel",
						"toggleterm",
						"neo-tree",
						"neo-tree-popup",
						"notify",
					},
				},
			},
			winbar = {
				lualine_c = {
					{
						function()
							return "%#Function# %#NavicText#"
									.. vim.fn.expand("%:p:h:t")
									.. " %#NavicSeparator#›%*"
						end,
						padding = 0,
					},
					{
						"filetype",
						icon_only = true,
						separator = "",
						color = { bg = "none" },
					},
					{
						"filename",
						padding = 0,
						color = "NavicText",
					},
					{
						function()
							local navic = require("nvim-navic")
							local data = navic.get_data()
							for i, context in pairs(data) do
								data[i].name = "%#NavicIcons" .. context.type .. "#" .. context.name .. "%*"
							end
							return navic.format_data(data, { safe_output = false })
						end,
						fmt = function(str)
							return str ~= "" and "%#NavicSeparator#› %*" .. str or nil
						end,
						cond = function()
							return require("nvim-navic").is_available()
						end,
					},
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "filename" },
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
		},
	},
}
