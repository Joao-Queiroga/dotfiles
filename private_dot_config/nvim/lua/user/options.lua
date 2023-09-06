local options = {
	mouse          = 'a',
	timeoutlen     = 300,
	number         = true,
	completeopt    = { "menuone", "noselect" },
	conceallevel   = 0,
	relativenumber = true,
	hlsearch       = false,
	incsearch      = true,
	ignorecase     = true,
	hidden         = true,
	encoding       = "UTF-8",
	errorbells     = false,
	tabstop        = 4,
	autoindent     = true,
	softtabstop    = 4,
	smarttab       = true,
	shiftwidth     = 4,
	scrolloff      = 7,
	backspace      = {'indent', 'eol', 'start'},
	expandtab      = false,
	smartindent    = true,
	cursorline     = true,
	wrap           = false,
	smartcase      = true,
	swapfile       = false,
	backup         = false,
	showmode       = false,
	undofile       = true,
	numberwidth    = 2,
	signcolumn     = 'yes',
	splitbelow     = true,
	splitright     = true,
	fileformat     = 'unix',
	foldcolumn     = '0',
	foldlevel      = 99,
	foldlevelstart = 99,
	foldenable     = true,
}

--set leader key
vim.g.mapleader      = " "

vim.opt.shortmess:append "c"
vim.opt.whichwrap:append('<,>,[,],h,l')
vim.cmd[[set iskeyword-=_]]

-- open .h files as C instead of C++
vim.cmd[[
	augroup filetypedetect
		au! BufRead,BufNewFile *.h setfiletype c
	augroup END
]]
vim.cmd [[
  augroup zsh_filetype
    autocmd!
    autocmd BufRead,BufNewFile ~/.config/zsh/functions/* setfiletype zsh
  augroup END
]]

for k, v in pairs(options) do
	vim.opt[k] = v
end
