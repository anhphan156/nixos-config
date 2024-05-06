local awful = require('awful')

local script = [[
    bash -c "uptime | awk -F ' ' '{print $3}' | tr -d ','"
]]

awful.widget.watch(script, 60, function(widget, stdout)
    awesome.emit_signal('daemon::uptime', stdout:gsub('\n',''))
end)
