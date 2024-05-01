local naughty = require("naughty")
local gears = require("gears")
local notification_widget = require("ui.notification_widget")

naughty.connect_signal("request::display", function(n)
	naughty.layout.box({
		notification = n,
		type = "notification",
		shape = gears.shape.rectangle,
		border_width = dpi(0),
		border_color = "#000000",
		position = "top_right",
		widget_template = notification_widget(n),
	})
end)
