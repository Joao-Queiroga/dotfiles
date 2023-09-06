local M = {}
function M.ly ()
	local term = require'toggleterm.terminal'.Terminal:new{
		cmd = 'lazygit -g ~/.local/share/yadm/repo.git -w ~',
		close_on_exit = true,
		direction = 'float'
	}
	term:open()
end

return M
