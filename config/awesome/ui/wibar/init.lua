local awful = require('awful')
local gears = require('gears')
local wibox = require('wibox')
local beautiful = require('beautiful')
local menubar = require('menubar')
local hotkeys_popup = require("awful.hotkeys_popup")

local button_maker = require('ui.components.button_maker')
local box_maker = require('ui.components.box_maker')

myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", user.terminal .. " -e man awesome" },
   { "edit config", user.editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

mymainmenu = awful.menu(
    {
        items = {
            { "awesome", myawesomemenu, beautiful.awesome_icon },
            { "open terminal", user.terminal }
        }
    }
)

mylauncher = awful.widget.launcher(
    {
        image = beautiful.awesome_icon,
        menu = mymainmenu 
    }
)

-- Menubar configuration
menubar.utils.terminal = user.terminal -- Set the terminal for applications that require it

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
    awful.button(
	{ }, 1,
	function(t) t:view_only() end
    ),

    awful.button(
	{ modkey }, 1,
	function(t)
	    if client.focus then
                client.focus:move_to_tag(t)
	    end
	end
    ),

    awful.button(
	{ }, 3,
	awful.tag.viewtoggle
    ),

    awful.button(
	{ modkey }, 3,
	function(t)
	    if client.focus then
	        client.focus:toggle_tag(t)
	    end
	end
    ),

    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

awful.screen.connect_for_each_screen(function(s)
    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    -- Create the wibox
    local wibar_margins = {
        top = dpi(10), bottom = dpi(10), left = dpi(10), right = dpi(10)
    } 
    local wibar_shape = function(cr, width, height)
        --gears.shape.partial_squircle(cr, width, height, false, true, true, true, dpi(10), dpi(0.09))
        gears.shape.rounded_rect(cr, width, height, 12)
    end

    s.mywibox = awful.wibar({
        position = 'top',
        screen = s,
        margins = wibar_margins,
        height = dpi(45),
        bg = beautiful.invisible
    })

    -- Add widgets to the wibox
    s.mywibox:setup ({
        {
            box_maker.box({ -- Left widgets
                mylauncher,

                button_maker.text_button(
                    'dashboard',
                     0,
                     beautiful.text_white_color,
                     function() awesome.emit_signal('dashboard::toggle') end
                ),

                s.mytaglist,

                layout = wibox.layout.fixed.horizontal,
            }, 12),

            box_maker.box({ -- Middle widgets
                widget = wibox.widget.textclock
            }, 12),

            box_maker.box({ -- Right widgets
                button_maker.text_button(
                    'emoji',
                    0,
                    beautiful.text_white_color,
                    function() awful.spawn.with_shell('rofi -modi emoji -show emoji') end
                ),
                mykeyboardlayout,
                wibox.widget.systray(),
                s.mylayoutbox,

                layout = wibox.layout.fixed.horizontal,
            }, 12),

            layout = wibox.layout.align.horizontal,
        },

        widget = wibox.container.background,
        bg = beautiful.invisible,
        shape = wibar_shape
    })
end)
