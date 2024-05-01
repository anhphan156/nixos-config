local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local naughty = require("naughty")

local ram_arcchart = wibox.container.arcchart()
-- local ram_text = wibox.widget.textbox()

local ram_box = wibox.widget({
	{
		{
			{
				forced_width = dpi(200),
				forced_height = dpi(160),
				border_width = dpi(0),
				bg = beautiful.battery_unplugged_background_color,
				colors = { beautiful.battery_green_color },
				thickness = dpi(25),
				start_angle = -1.57079632679,
				rounded_edge = true,
				value = 90,
				min_value = 0,
				max_value = 100,
				widget = ram_arcchart,
			},
			{
				{
					widget = wibox.widget.imagebox,
					image = beautiful.ram_icon,
					forced_width = dpi(80),
					forced_height = dpi(80),
				},
				widget = wibox.container.place,
			},
			layout = wibox.layout.stack,
		},
		widget = wibox.container.place,
	},
	widget = wibox.container.background,
	bg = beautiful.titlebar_bg_normal,
	shape = function(cr, width, height)
		gears.shape.rounded_rect(cr, width, height, 12)
	end,
})

awesome.connect_signal("daemon::ram", function(free_percentage)
	local value = 100 - tonumber(free_percentage) * 100
	ram_arcchart.value = value
	-- ram_text.text = 100 - free_percentage * 100

	if value < 50 then
		ram_arcchart.colors = { beautiful.battery_green_color }
	elseif value < 80 then
		ram_arcchart.colors = { beautiful.battery_yellow_color }
	else
		ram_arcchart.colors = { beautiful.battery_red_color }
	end
end)

return ram_box
