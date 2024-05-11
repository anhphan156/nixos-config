local wibox = require('wibox')
local beautiful = require('beautiful')
local gears = require('gears')
local awful = require('awful')
local button_maker = require('ui.components.button_maker')
local naughty = require('naughty')

local icon_size = dpi(200)
local s_width = awful.screen.focused().geometry.width
local s_height = awful.screen.focused().geometry.height
local menu_width = 600
local menu_height = 250
local placement_left = (s_width - menu_width) / 2.0;
local placement_top = (s_height - menu_height) / 2.0;

local power_menu = awful.popup{
	widget = wibox.container.background,
    bg = beautiful.titlebar_bg_normal,
	visible = false,
	ontop = true,
	border_width = dpi(3),
    border_color = beautiful.text_red_color,
    shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, beautiful.corner_radius)
    end,
	placement = function(c)
		awful.placement.top_left(c,
			{ 
                margins = { 
                    top = placement_top,
                    bottom = dpi(0),
                    left = placement_left,
                    right = dpi(0) 
                } 
            }
		)
	end,
}

power_menu:setup({
    {
        button_maker.icon_button(
            beautiful.poweroff_icon,
            dpi(0),
            icon_size,
            icon_size,
            function() awful.spawn.with_shell('shutdown -h now') end
        ),
        button_maker.icon_button(
            beautiful.repeat_icon,
            dpi(0),
            icon_size,
            icon_size,
            function() awful.spawn.with_shell('reboot') end
        ),
        button_maker.icon_button(
            beautiful.lock_icon,
            dpi(0),
            icon_size,
            icon_size,
            function() 
                power_menu.visible = false
                awesome.emit_signal('lockscreen::lock') 
            end
        ),
        layout = wibox.layout.fixed.horizontal    
    },
    widget = wibox.container.place,
    forced_width = dpi(menu_width),
    forced_height = dpi(menu_height)
})

awesome.connect_signal('acpi::power_button', function() 
    power_menu.visible = not power_menu.visible
end)
