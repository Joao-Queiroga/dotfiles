local wezterm = require 'wezterm'
local action = wezterm.action
local functions = require'utils.functions'

local keys = {
  {
    key = '%',
    mods = 'LEADER|SHIFT',
    action = action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = '"',
    mods = 'LEADER|SHIFT',
    action = action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'c',
    mods = 'LEADER',
    action = action.SpawnTab('CurrentPaneDomain'),
  },
	{
    key = '&',
    mods = 'LEADER',
    action = action.CloseCurrentTab { confirm=true },
  },
  {
    key = 'x',
    mods = 'LEADER',
    action = action.CloseCurrentPane { confirm=true },
  },
	-- Switch Tabs with Alt+Shift+hjkl
	{
		key = 'h',
		mods = 'ALT|SHIFT',
		action = action.ActivateTabRelative(-1)
	},
	{
		key = 'l',
		mods = 'ALT|SHIFT',
		action = action.ActivateTabRelative(1)
	},
	-- Switch Panes with Ctrl-hjkl
	functions.bind_if(functions.is_outside_vim, {
		key = 'h',
		mods = 'CTRL',
		action = action.ActivatePaneDirection('Left')
	}),
	functions.bind_if(functions.is_outside_vim, {
		key = 'j',
		mods = 'CTRL',
		action = action.ActivatePaneDirection('Down')
	}),
	functions.bind_if(functions.is_outside_vim, {
		key = 'k',
		mods = 'CTRL',
		action = action.ActivatePaneDirection('Up')
	}),
	functions.bind_if(functions.is_outside_vim, {
		key = 'l',
		mods = 'CTRL',
		action = action.ActivatePaneDirection('Right')
	}),
  -- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
  {
    key = 'a',
    mods = 'LEADER|CTRL',
    action = action.SendKey { key = 'a', mods = 'CTRL' },
  },
}

for i = 0, 9 do
	table.insert(keys, {
		key = tostring(i),
		mods = 'LEADER',
		action = action.ActivateTab(i),
	})
end

return keys
