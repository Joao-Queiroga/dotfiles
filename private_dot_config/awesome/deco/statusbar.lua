-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Wibox handling library
local wibox = require("wibox")

local deco = {
	wallpaper = require("deco.wallpaper"),
	taglist = require("deco.taglist"),
	tasklist = require("deco.tasklist")
}

local taglist_buttons = deco.taglist()
local tasklist_buttons = deco.tasklist()

-- Wibar

-- Create a textclock widget
local mytextclock = wibox.widget.textclock()
mytextclock.format = '<span font_size="9.5pt" foreground="#ffb86c"><span font_size="11pt"></span> %a %d/%m/%y %H:%M</span>'

awful.screen.connect_for_each_screen(function(s)
	-- Wallpaper
	set_wallpaper(s)

	-- Create a promptbox for each screen
	s.mypromptbox = awful.widget.prompt()

	-- Create an imagebox widget 
	s.mylayoutbox = awful.widget.layoutbox(s)
	s.mylayoutbox:buttons(gears.table.join(
		awful.button({ }, 1, function () awful.layout.inc( 1) end),
		awful.button({ }, 3, function () awful.layout.inc(-1) end),
		awful.button({ }, 4, function () awful.layout.inc( 1) end),
		awful.button({ }, 5, function () awful.layout.inc(-1) end)
	))

	-- Create a taglist widget
	s.mytaglist = awful.widget.taglist {
		screen = s,
		filter = function (t)
			return t.name ~= nil
		end,
		buttons = taglist_buttons,
	}

	-- Create a tasklist widget
	s.mytasklist = awful.widget.tasklist {
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = tasklist_buttons
	}

	-- Create the wibox
	s.mywibox = awful.wibar({ position = "top", screen = s })

	-- Add widgets to the wibox
	s.mywibox:setup {
		layout = wibox.layout.align.horizontal,
		{ -- Left widgets
			layout = wibox.layout.fixed.horizontal,
			-- RC.launcher,
			s.mytaglist,
			s.mypromptbox,
			s.mylayoutbox,
		},
		s.mytasklist, -- Middle widget
		{ -- Right widgets
			layout = wibox.layout.fixed.horizontal,
			spacing = 7,
			-- mykeyboardlayout,
			wibox.widget.systray(),
			widgets.cpu,
			widgets.memory,
			widgets.volume,
			mytextclock,
		},
	}
end)
