local wibox = require("wibox")
local gears = require("gears")
local naughty = require("naughty")

local progress_container = wibox.container.radialprogressbar();

local progress_notification_widget = function(n)
	return wibox.widget({
		{
			{
				{
                    {
                        -- {
                        --     widget = wibox.widget.textbox,
                        --     markup = "<b>" .. n.title .. "</b>",
                        --     wrap = "word_char",
                        -- },
                        {
                            widget = naughty.widget.message,
                            -- halign = 'center'
                        },
                        widget = wibox.container.place
                    },
                    value     = 10,
                    max_value = 100,
                    min_value = 0,
                    paddings = dpi(2),
                    forced_width = dpi(180),
                    forced_height = dpi(60),
                    widget = progress_container
                },
				widget = wibox.container.margin,
				margins = {
					top = dpi(25),
					bottom = dpi(25),
					left = dpi(40),
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

awesome.connect_signal('audio::adjust', function(audio_level) 
    progress_container.value = tonumber(audio_level)
end)

return progress_notification_widget
