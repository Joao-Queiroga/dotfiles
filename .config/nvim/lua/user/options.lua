local options = {
	mouse = "a",
	timeoutlen = 500,
	number = true,
	completeopt = { "menuone", "noselect" },
	conceallevel = 0,
	relativenumber = true,
	hlsearch = false,
	incsearch = true,
	ignorecase = true,
	hidden = true,
	encoding = "UTF-8",
	errorbells = false,
	tabstop = 2,
	autoindent = true,
	softtabstop = 4,
	smarttab = true,
	shiftwidth = 2,
	scrolloff = 7,
	backspace = { "indent", "eol", "start" },
	expandtab = true,
	smartindent = true,
	cursorline = true,
	wrap = false,
	smartcase = true,
	swapfile = false,
	backup = false,
	showmode = false,
	undofile = true,
	numberwidth = 2,
	signcolumn = "yes",
	splitbelow = true,
	splitright = true,
	fileformat = "unix",
	foldcolumn = "0",
	foldlevel = 99,
	foldlevelstart = 99,
	foldenable = true,
}

--set leader key
vim.g.mapleader = " "

vim.opt.shortmess:append("c")
vim.opt.whichwrap:append("<,>,[,],h,l")
vim.cmd([[set iskeyword-=_]])

for k, v in pairs(options) do
	vim.opt[k] = v
end
