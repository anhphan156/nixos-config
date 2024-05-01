local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")

local function set_wallpaper(s)
	awful.wallpaper({
		screen = s,
		widget = {
			{
				image = beautiful.wallpaper,
				upscale = true,
				downscale = true,
				widget = wibox.widget.imagebox,
			},
			valign = "center",
			halign = "center",
			tited = false,
			widget = wibox.container.tile,
		},
	})
end

screen.connect_signal("request::wallpaper", set_wallpaper)

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)
