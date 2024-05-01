local awful = require("awful")

local script = [[
    cat /sys/class/power_supply/BAT0/capacity
]]

awful.widget.watch(script, 300, function(widget, stdout)
	awesome.emit_signal("daemon::battery", stdout:gsub("\n", ""))
end)
