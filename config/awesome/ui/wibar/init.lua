local awful = require('awful')
local gears = require('gears')
local wibox = require('wibox')
local beautiful = require('beautiful')
local menubar = require('menubar')
local hotkeys_popup = require("awful.hotkeys_popup")
local dpi = beautiful.xresources.apply_dpi

local button_maker = require('ui.components.button_maker')

require('ui.popups.dashboard')

terminal = 'kitty'
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

mymainmenu = awful.menu(
    {
        items = {
            { "awesome", myawesomemenu, beautiful.awesome_icon },
            { "open terminal", terminal }
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
menubar.utils.terminal = terminal -- Set the terminal for applications that require it

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

local tasklist_buttons = gears.table.join(
    awful.button(
	{ }, 1,
	function (c)
            if c == client.focus then
                c.minimized = true
            else
                c:emit_signal(
                    "request::activate",
                    "tasklist",
                    {raise = true}
                )
            end
        end
    ),

    awful.button(
	{ }, 3,
	function()
            awful.menu.client_list({ theme = { width = 250 } })
        end
    ),

    awful.button(
        { }, 4,
        function ()
            awful.client.focus.byidx(1)
        end
    ),

    awful.button(
        { }, 5,
        function ()
            awful.client.focus.byidx(-1)
        end
    )
)

awful.screen.connect_for_each_screen(function(s)
    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
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

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }

    -- Create the wibox
    local wibar_margins = {
        top = dpi(10), bottom = dpi(0), left = dpi(10), right = dpi(10)
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
            { -- Left widgets
                mylauncher,

                button_maker.text_button(
                    'dashboard',
                     15,
                     function() awesome.emit_signal('dashboard::toggle') end
                ),

                s.mytaglist,
                s.mypromptbox,

                layout = wibox.layout.fixed.horizontal,
            },

            --s.mytasklist, -- Middle widget

            {
                align = 'center',
                widget = wibox.widget.textclock
            },

            { -- Right widgets
                mykeyboardlayout,
                wibox.widget.systray(),
                s.mylayoutbox,

                layout = wibox.layout.fixed.horizontal,
            },

            layout = wibox.layout.align.horizontal,
        },

        widget = wibox.container.background,
        bg = '#333333',
        shape = wibar_shape
    })
end)
