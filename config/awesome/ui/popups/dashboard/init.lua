local awful = require('awful')
local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi
local gears = require('gears')
local wibox = require('wibox')
local naughty = require('naughty')

local profile_box = require('ui.popups.dashboard.profile_box')
local uptime_box = require('ui.popups.dashboard.uptime_box')
local battery_box = require('ui.popups.dashboard.battery_box')

local dashboard = awful.popup {
    widget = wibox.container.background,
    bg = beautiful.invisible,
    --bg = '#990000',
    visible = true,
    forced_width = 1980,
    maximum_width = 1980,
    maximum_height = 720,
    ontop = true,
    border_width = 0,
    placement = function(c)
        awful.placement.top_left(
            c,
            { margins = { top = dpi(200), bottom = dpi(10), left = dpi(100), right = dpi(10),} }
        )
    end,
}

local make_box = function(text)
    return wibox.widget{
        {
            text = text,
            widget = wibox.widget.textbox
        },
        widget = wibox.container.background,
        bg = beautiful.titlebar_bg_normal 
    }
end

local grid = wibox.widget {
    {
        row_index = 1,
        col_index = 1,
        row_span = 7,
        col_span = 2,
        widget = profile_box
    },
    {
        row_index = 8,
        col_index = 1,
        row_span = 1,
        col_span = 2,
        widget = uptime_box
    },
    {
        row_index = 1,
        col_index = 3,
        row_span = 3,
        col_span = 2,
        widget = battery_box
    },
    {
        row_index = 2,
        col_index = 5,
        row_span = 3,
        col_span = 2,
        widget = make_box('test')
    },
    {
        row_index = 1,
        col_index = 7,
        row_span = 6,
        col_span = 3,
        widget = make_box('test')
    },
    homogeneous = true,
    expand = false,
    spacing = 8,
    column_count = 9,
    min_cols_size = dpi(180),
    min_rows_size = dpi(80),
    layout = wibox.layout.grid
}

dashboard:setup{
    grid,
    widget = wibox.container.place
}

awesome.connect_signal(
    'dashboard::toggle',
    function()
        dashboard.visible = not dashboard.visible 
    end
)

return dashboard
