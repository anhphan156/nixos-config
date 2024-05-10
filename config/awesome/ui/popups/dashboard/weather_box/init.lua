local wibox = require("wibox")
local beautiful = require("beautiful")
local box_maker = require("ui.components.box_maker")

local weather_text = wibox.widget.textbox()
local weather_icon = wibox.widget.imagebox()

local weather_box = wibox.widget({
	box_maker.flex_box({
		{
			{
				{
					widget = weather_icon,
					forced_width = dpi(50),
					forced_height = dpi(50),
				},
				widget = wibox.container.place,
			},
			{
				widget = weather_text,
				font = "Sans 16",
				text = "weather",
			},
			layout = wibox.layout.fixed.vertical,
		},
		widget = wibox.container.place,
	}),
	widget = wibox.container.background,
})

awesome.connect_signal("daemon::weather", function(weather_data)
	local icon_code = string.sub(weather_data, -1)
	weather_data = weather_data:sub(1, -2)

	local icon_map = {}
	icon_map[1] = beautiful.overcast_icon
	icon_map[2] = beautiful.rain_icon
	icon_map[3] = beautiful.cloud_icon
	icon_map[4] = beautiful.mist_icon
	icon_map[5] = beautiful.mist_icon
	icon_map[6] = beautiful.clear_icon
	icon_map[7] = beautiful.sunny_icon

	--weather_text.markup = '<b>'.. weather_data .. '</b>'
	weather_text.text = weather_data
	weather_icon.image = icon_map[tonumber(icon_code)]
end)

return weather_box
