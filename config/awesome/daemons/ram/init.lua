local awful = require("awful")

local interval = 120
-- local script = [[bash -c "grep MemFree /proc/meminfo | awk -F ' ' '{print $2}'"]]
local script =
	[[bash -c "echo \"scale=2 ; $(grep MemFree /proc/meminfo | awk -F ' ' '{print $2}') / $(grep MemTotal /proc/meminfo | awk -F ' ' '{print $2}')\" | bc"]]

awful.widget.watch(script, interval, function(widget, stdout)
	awesome.emit_signal("daemon::ram", stdout)
end)
