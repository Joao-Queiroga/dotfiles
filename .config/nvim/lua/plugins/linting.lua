return {
	{
		"mfussenegger/nvim-lint",
		event = { "BufWrite", "BufRead", "InsertLeave" },
		dependencies = { "mason-tool-installer.nvim" },
		opts = {
			events = { "BufWritePost", "BufReadPost", "InsertLeave" },
			linters_by_ft = {
				fish = { "fish" },
				python = { "flake8" },
				java = { "checkstyle" },
			},
		},
		config = function(_, opts)
			local lint = require("lint")
			lint.linters_by_ft = opts.linters_by_ft
			vim.api.nvim_create_autocmd(opts.events, {
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},
}
