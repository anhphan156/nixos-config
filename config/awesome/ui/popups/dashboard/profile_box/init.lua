local beautiful = require('beautiful')
local wibox = require('wibox')
local gears = require('gears')

local profile_box = wibox.widget {
    {
        {
            {
                {
                    image = beautiful.profile_pic,
                    resize = true,
                    forced_height = dpi(300),
                    forced_width = dpi(300),
                    clip_shape = function(cr, width, height)
                        gears.shape.circle(cr, width, height)
                    end,
                    widget = wibox.widget.imagebox
                },
                margins = {
                    top = dpi(0),
                    bottom = dpi(0),
                    left = dpi(65),
                    right = dpi(0),
                },
                widget = wibox.container.margin
            },
            {
                {
                    markup = '<b>' .. user.name .. '</b>',
                    font = 'sans 25',
                    widget = wibox.widget.textbox
                },
                widget = wibox.container.place
            },
            layout = wibox.layout.align.vertical
        },
        widget = wibox.container.place
    },
    widget = wibox.container.background,
    bg = beautiful.titlebar_bg_normal,
    shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, 12)
    end
}

return profile_box
