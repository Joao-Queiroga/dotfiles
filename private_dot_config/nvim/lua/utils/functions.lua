local M = {}
function M.float_term (command)
	local term = require'toggleterm.terminal'.Terminal:new{
		cmd = command,
		close_on_exit = true,
		direction = 'float'
	}
	term:open()
end

return M
