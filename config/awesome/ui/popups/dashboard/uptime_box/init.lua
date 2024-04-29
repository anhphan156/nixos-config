local beautiful = require('beautiful')
local wibox = require('wibox')
local gears = require('gears')

local textbox = wibox.widget.textbox()
textbox.markup = 'Getting Uptime'

local uptime_box = wibox.widget {
    
    {
        {
            {
                {
                    image = beautiful.uptime_icon,
                    forced_width = dpi(50),
                    forced_height = dpi(50),
                    widget = wibox.widget.imagebox
                },
                margins = {
                    top = dpi(3),
                    bottom = dpi(0),
                    left = dpi(0),
                    right = dpi(0),
                },
                widget = wibox.container.margin
            },
            {
                font = 'sans 18',
                widget = textbox,
            },
            layout = wibox.layout.fixed.horizontal
        },
        widget = wibox.container.place
    },

    widget = wibox.container.background,
    bg = beautiful.titlebar_bg_normal,
    shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, 12)
        --gears.shape.partially_rounded_rect(cr, width, height, true, false, true, true, 15)
    end
}

awesome.connect_signal('daemon::uptime', function(uptime)
    textbox.text = uptime
end)

return uptime_box
