return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufRead", "BufNewFile", "VeryLazy" },
		dependencies = {
			"nvim-treesitter/playground",
			"hiphish/rainbow-delimiters.nvim",
			"nvim-treesitter/nvim-treesitter-refactor",
			"windwp/nvim-ts-autotag",
		},
		main = "nvim-treesitter.configs",
		build = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
		opts = {
			ensure_installed = "all",
			ignore_install = { "org" },
			sync_install = false,
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = { "org" },
			},
			indent = {
				enable = true,
			},
			rainbow = {
				enable = true,
				extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
				max_file_lines = nil, -- Do not enable for files with more than n lines, int
			},
			refactor = {
				highlight_current_scope = true,
				smart_rename = {
					enable = true,
					keymaps = {
						smart_rename = "grr",
					},
				},
			},
			autotag = {
				enable = true,
			},
			playground = {
				enable = true,
				disable = {},
				updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
				persist_queries = false, -- Whether the query persists across vim sessions
				keybindings = {
					toggle_query_editor = "o",
					toggle_hl_groups = "i",
					toggle_injected_languages = "t",
					toggle_anonymous_nodes = "a",
					toggle_language_display = "I",
					focus_language = "f",
					unfocus_language = "F",
					update = "R",
					goto_node = "<cr>",
					show_help = "?",
				},
			},
		},
	},
	{
		"luckasRanarison/tree-sitter-hypr",
		dependencies = "nvim-treesitter/nvim-treesitter",
		event = { "BufRead", "BufNewFile", "VeryLazy" },
		config = function()
			require("nvim-treesitter.parsers").get_parser_configs().hypr = {
				install_info = {
					url = "https://github.com/luckasRanarison/tree-sitter-hypr",
					files = { "src/parser.c" },
					branch = "master",
				},
				filetype = "hypr",
			}
		end,
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		event = "BufRead",
		dependencies = "nvim-treesitter/nvim-treesitter",
		opts = {},
	},
}
