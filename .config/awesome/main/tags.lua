local awful = require("awful")

local _M = {}

function _M.get()
	local tags = {}
	awful.screen.connect_for_each_screen(function (s)
		tags[s] = awful.tag(
			{ "dev", "www", "sys", "doc", "vbox", "chat", "class", "fics", "games", "" }, s, RC.layouts[1]
		)
	end)
	return tags
end

return setmetatable(
	{},
	{__call = function(_, ...) return _M.get(...)	end}
)
