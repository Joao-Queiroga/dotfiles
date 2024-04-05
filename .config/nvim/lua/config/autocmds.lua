local autocmd = vim.api.nvim_create_autocmd

-- open .h files as C instead of C++
autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.h",
	callback = function()
		vim.bo.filetype = "c"
	end,
})

-- Open files in zsh functions folder as zsh
autocmd({ "BufRead", "BufNewFile" }, {
	pattern = vim.fn.expand("~/.config/zsh/functions/*"),
	callback = function()
		vim.bo.filetype = "zsh"
	end,
})

-- Add neovim files to yadm on creation
autocmd({ "BufNewFile" }, {
	pattern = vim.fn.expand("~/.config/nvim/**", true, true),
	callback = function()
		os.execute("yadm add " .. vim.api.nvim_buf_get_name(0))
	end,
})

-- change yadm git env vars on leaving neogit
autocmd({ "BufWinLeave" }, {
	callback = function(opts)
		if vim.bo[opts.buf].filetype == "NeogitStatus" and vim.env.GIT_WORK_TREE == vim.fn.expand("~") then
			vim.env.GIT_DIR = nil
			vim.env.GIT_WORK_TREE = nil
		end
	end,
})

-- change cwd when editing a config file
autocmd({ "BufRead", "BufNewFile" }, {
	pattern = vim.fn.expand("~/.config/*/*", true, true),
	callback = function()
		vim.cmd("cd " .. vim.fn.expand("%:p:h"))
	end,
})
