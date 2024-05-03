local wibox = require("wibox")

local notification_widget = function(n)
	return wibox.widget({
		{
			{
				{
					{
						widget = wibox.widget.textbox,
						markup = "<b>" .. n.title .. "</b>",
						wrap = "word_char",
					},
					{
						widget = wibox.widget.textbox,
						markup = n.message,
						wrap = "word_char",
					},
					layout = wibox.layout.flex.vertical,
				},
				widget = wibox.container.margin,
				margins = {
					top = dpi(25),
					bottom = dpi(25),
					left = dpi(50),
					right = dpi(50),
				},
			},
			strategy = "max",
			--width = dpi(850),
			--height = dpi(180),
			widget = wibox.container.constraint,
		},
		widget = wibox.container.background,
	})
end

return notification_widget
