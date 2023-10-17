local wezterm = require 'wezterm'

local M = {}

function M.bind_if(cond, keybinding)
	local key = keybinding.key
	local mods = keybinding.mods
	local action = keybinding.action
  local function callback (win, pane)
    if cond(pane) then
      win:perform_action(action, pane)
    else
      win:perform_action(wezterm.action.SendKey({key=key, mods=mods}), pane)
    end
  end

  return { key=key, mods=mods, action=wezterm.action_callback(callback) }
end

function M.is_inside_vim(pane)
  local tty = pane:get_tty_name()
  if tty == nil then return false end

  local success, _, _= wezterm.run_child_process
    { 'sh', '-c',
      'ps -o state= -o comm= -t' .. wezterm.shell_quote_arg(tty) .. ' | ' ..
      'grep -iqE \'^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?)(diff)?$\'' }

  return success
end

function M.is_outside_vim(pane) return not M.is_inside_vim(pane) end

return M
