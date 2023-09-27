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

-- Add neovim files to chezmoi on save
autocmd({ "BufWritePost" }, {
	pattern = vim.fn.expand("~/.config/nvim/**", true, true),
	callback = function()
		os.execute('chezmoi add ' .. vim.api.nvim_buf_get_name(0))
	end,
})

-- Apply chezmoi on neogit exit
autocmd({ "BufWinLeave" }, {
	callback = function(opts)
		if vim.bo[opts.buf].filetype == 'NeogitStatus' and vim.fn.getcwd() == vim.fn.expand('~/.local/share/chezmoi') then
			os.execute("chezmoi apply")
		end
	end,
})

