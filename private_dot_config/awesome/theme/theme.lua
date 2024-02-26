local gears = require("gears")

theme_path = gears.filesystem.get_configuration_dir() .. "theme/"


-- default variables

theme = {}

dofile(theme_path .. "elements.lua")
dofile(theme_path .. "titlebar.lua")
dofile(theme_path .. "layouts.lua")

theme.wallpaper          = RC.vars.wallpaper
theme.awesome_icon       = theme_path .. "icons/awesome64.png"
-- theme.awesome_icon       = gears.filesystem.get_awesome_icon_dir() .. "awesome64.png"

-- Icon Theme
theme.icon_theme = RC.vars.icon_theme

return theme
