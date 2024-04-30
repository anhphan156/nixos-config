local wibox = require('wibox')
local beautiful = require('beautiful')
local gears = require('gears')

local box_maker = {}

box_maker.flex_box = function(content_widget)
    return wibox.widget{
        content_widget,
        widget = wibox.container.background,
        bg = beautiful.titlebar_bg_normal,
        shape = function(cr, width, height) gears.shape.rounded_rect(cr, width, height, 12) end
    }
end

box_maker.box = function(content_widget, margin)
    return wibox.widget({
        {
            {
                content_widget,
                widget = wibox.container.margin,
                margins = dpi(margin)
            },
            widget = wibox.container.background,
            bg = beautiful.titlebar_bg_normal,
            shape = function(cr, width, height) gears.shape.rounded_rect(cr, width, height, 12) end
        },
        widget = wibox.container.place,
    })
end

return box_maker
