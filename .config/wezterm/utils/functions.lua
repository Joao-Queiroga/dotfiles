local wezterm = require("wezterm")

local M = {}

function M.bind_if(cond, keybinding)
	local key = keybinding.key
	local mods = keybinding.mods
	local action = keybinding.action
	local function callback(win, pane)
		if cond(pane) then
			win:perform_action(action, pane)
		else
			win:perform_action(wezterm.action.SendKey({ key = key, mods = mods }), pane)
		end
	end

	return { key = key, mods = mods, action = wezterm.action_callback(callback) }
end

function M.is_vim(pane)
	return pane:get_user_vars().IS_NVIM == "true" or pane:get_foreground_process_name():find("n?vim")
end

function M.is_outside_vim(pane)
	return not M.is_vim(pane)
end

function M.is_tmux(pane)
	return pane:get_user_vars().TMUX
		or pane:get_foreground_process_name():find("tmux")
		or pane:get_foreground_process_name():find("tmux attach")
end

function M.is_not_tmux()
	return not M.is_tmux()
end

return M
