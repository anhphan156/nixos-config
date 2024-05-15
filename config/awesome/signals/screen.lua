local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local layoutbox = require("ui.wibar.layoutbox")
local taglist = require("ui.wibar.taglist")
local wibar = require("ui.wibar")

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

awful.screen.connect_for_each_screen(function(s)
	s.systray = wibox.widget.systray()

    s.mylayoutbox = layoutbox(s)

	awful.tag({ "1", "2", "3", "4", "5", "6", "7" }, s, awful.layout.layouts[1])
    s.mytaglist = taglist(s)

    s.mywibox = wibar(s)
end)
