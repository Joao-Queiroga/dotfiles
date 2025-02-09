--Wibar widgets
local lain = require("lain")
local markup = lain.util.markup
local beautiful = require("beautiful")

local widgets = {}
local font = "JetbrainsMono Nerd Font 11"

widgets.cpu = lain.widget.cpu({
	settings = function()
		widget:set_markup(markup.fontfg(font, "#ff5555", "  " .. cpu_now.usage .. "%"))
	end,
})

widgets.memory = lain.widget.mem({
	timeout = 1,
	settings = function()
		widget:set_markup(markup.fontfg(font, "#f1fa8c", "󰍛 " .. mem_now.used .. "M"))
	end,
})

widgets.volume = lain.widget.alsa({
	timeout = 2,
	settings = function()
		if not volume_now.level then
			return
		end
		local volume_icon = volume_now.status == "on" and "󰕾 " or "󰝟 "
		widget:set_markup(markup.fontfg(font, "#50fa7b", volume_icon .. volume_now.level .. "%"))
	end,
})

return widgets
