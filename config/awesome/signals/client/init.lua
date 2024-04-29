local naughty = require("naughty")
local beautiful = require("beautiful")
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c, {position = "left"}) : setup {
	{
	    { 
	        awful.titlebar.widget.closebutton    (c),
	        awful.titlebar.widget.maximizedbutton(c),
	        awful.titlebar.widget.minimizebutton   (c),
		spacing = dpi(5),
	        layout = wibox.layout.fixed.vertical()
	    },
	    margins = dpi(5),
	    widget = wibox.container.margin
	},
	{
	    spacing = 0,
	    spacing_widget = wibox.widget.separator,
            layout  = wibox.layout.flex.vertical
	},
        --{
        --    { -- Title
        --        align  = "left",
        --        widget = awful.titlebar.widget.titlewidget(c)
        --    },
        --    buttons = buttons,
        --    layout  = wibox.layout.flex.horizontal
        --},
	{
            {
                awful.titlebar.widget.iconwidget(c),
                buttons = buttons,
                layout  = wibox.layout.fixed.vertical
            },
	    margins = dpi(3),
	    widget = wibox.container.margin
	},
        layout = wibox.layout.align.vertical
    }
end)

-- Sloppy focus
client.connect_signal("mouse::enter", function(c)
    --naughty.notify({
    --    title = "mouse entered"
    --})
    --c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)
