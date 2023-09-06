pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local menubar = require("menubar")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

RC = {}
RC.vars = require("main.user-variables")
modkey = RC.vars.modkey

-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme/theme.lua")

widgets = require("deco.lain-widgets")

-- Error handling
require("main.error-handling")

-- Custom Local Library
local main = {
	layouts = require("main.layouts"),
	tags = require("main.tags"),
	menu = require("main.menu"),
	rules = require("main.rules")
}

-- Custom Local Library: Keys and Mouse Binding
local bidding = {
	globalbuttons = require("bindings.globalbuttons"),
	clientbuttons = require("bindings.clientbuttons"),
	globalkeys = require("bindings.globalkeys"),
	bindtotags = require("bindings.bindtotags"),
	clientkeys = require("bindings.clientkeys")
}

-- Custom Local Library: Common Functional Decoration
local deco = {
	wallpaper = require("deco.wallpaper"),
	taglist   = require("deco.taglist"),
	tasklist  = require("deco.tasklist")
}

RC.layouts = main.layouts()

RC.tags = main.tags()

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = RC.layouts

-- Menu
RC.mainmenu = awful.menu({ items = main.menu() })
RC.launcher = awful.widget.launcher(
	{ image = beautiful.awesome_icon, menu = RC.mainmenu }
)

menubar.utils.terminal = RC.vars.terminal

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- Wibar
require("deco.statusbar")

-- Set Mouse and Key bindings
RC.globalkeys = bidding.globalkeys()
RC.globalkeys = bidding.bindtotags(RC.globalkeys)

-- Set root
root.buttons(bidding.globalbuttons())
root.keys(RC.globalkeys)

-- Rules
awful.rules.rules = main.rules(
	bidding.clientkeys(),
	bidding.clientbuttons()
)

-- Signals
require("main.signals")

-- Autostart
require("main.autostart")
