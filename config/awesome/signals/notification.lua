local naughty = require("naughty")
local gears = require("gears")
local notification_widget = require("ui.notification_widget")
local progress_notification_widget = require("ui.notification_widget.progress_notification")

naughty.connect_signal("request::display", function(n)
    local widget_template
    if n.app_name == 'progress_notification' then
        widget_template = progress_notification_widget
    else
        widget_template = notification_widget
    end
        
	naughty.layout.box({
		notification = n,
		type = "notification",
		shape = gears.shape.rectangle,
		border_width = dpi(0),
		border_color = "#000000",
		position = "top_right",
		widget_template = widget_template(n),
	})
end)
