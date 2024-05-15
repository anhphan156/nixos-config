local awful = require('awful')
local naughty = require('naughty')

local notification_obj
local progress_notify = function(script)
    awful.spawn.easy_async_with_shell(script, function(stdout)
        local message = stdout:gsub('\n','')
        if notification_obj ~= nil then
            notification_obj = naughty.notify({
                replaces_id = notification_obj.id,
                title = 'Volume',
                message = message,
                app_name = 'progress_notification'
            })
        else
            notification_obj = naughty.notification({
                title = 'Volume',
                message = message,
                app_name = 'progress_notification'
            })
        end

        awesome.emit_signal('audio::adjust', message)
    end)
end

awful.keyboard.append_global_keybindings({
	awful.key({}, "XF86AudioRaiseVolume", function()
		awful.spawn.with_shell("pamixer -i 5")
        progress_notify('pamixer --get-volume')
	end),
	awful.key({}, "XF86AudioLowerVolume", function()
		awful.spawn.with_shell("pamixer -d 5")
        progress_notify('pamixer --get-volume')
	end),

	awful.key({}, "XF86AudioMute", function()
		awful.spawn.with_shell("pamixer -t")
	end),

	awful.key({}, "XF86MonBrightnessUp", function()
		awful.spawn.with_shell("xbacklight -inc 5")
        progress_notify('xbacklight -get')
	end),

	awful.key({}, "XF86MonBrightnessDown", function()
		awful.spawn.with_shell("xbacklight -dec 5")
        progress_notify('xbacklight -get')
	end),
})
