local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local naughty = require("naughty")

local battery_arcchart = wibox.container.arcchart()
-- local battery_text = wibox.widget.textbox()

local low_warning = true
local is_plugged = false

local battery_box = wibox.widget({
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
				widget = battery_arcchart,
			},
			{
				{
					widget = wibox.widget.imagebox,
					image = beautiful.battery_icon,
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

awesome.connect_signal("daemon::battery", function(percentage)
	if percentage == "" then percentage = "100" end

	battery_arcchart.value = percentage
	-- battery_text.text = percentage .. "%"

	if tonumber(percentage) < 15 then
		battery_arcchart.colors = { beautiful.battery_red_color }
		if low_warning then
			naughty.notify({
				title = "Alert",
				text = "Battery is low",
				timeout = 0
			})
			low_warning = false
		end
	elseif tonumber(percentage) < 50 then
		battery_arcchart.colors = { beautiful.battery_yellow_color }
		low_warning = true
	elseif tonumber(percentage) < 101 then
		battery_arcchart.colors = { beautiful.battery_green_color }
		low_warning = true
	end
end)

awesome.connect_signal("acpi::plugged", function()
	naughty.notify({
		title = "ACPI Event",
		text = "Laptop is charging",
	})
	is_plugged = true
	battery_arcchart.bg = beautiful.battery_plugged_background_color
end)

awesome.connect_signal("acpi::unplugged", function()
	naughty.notify({
		title = "ACPI Event",
		text = "Laptop stopped charging",
	})
	is_plugged = false
	battery_arcchart.bg = beautiful.battery_unplugged_background_color
end)

return battery_box
