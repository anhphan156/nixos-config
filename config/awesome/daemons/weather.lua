local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")

local interval = 3600
local file = "~/.cache/apicalls/last_weather.text"

local script = [[bash -c '
    result=$(curl -sf "http://api.weatherapi.com/v1/current.json?key=]] .. user.weather_api_key .. [[&q=l6y2w8&aqi=no")

    if [ ! -z "$result" ]; then
        condition=$(echo $result | jq '.current.condition.text' | tr -d \") 
        temp=$(echo $result | jq '.current.temp_c') 
        if [ "${condition,,}" = "overcast" ]; then
            code=1
        elif [ "${condition,,}" = "light rain" ]; then
            code=2
        elif [ "${condition,,}" = "partly cloudy" ]; then
            code=3
        elif [ "${condition,,}" = "mist" ]; then
            code=4
        elif [ "${condition,,}" = "fog" ]; then
            code=5
        elif [ "${condition,,}" = "clear" ]; then
            code=6
        elif [ "${condition,,}" = "sunny" ]; then
            code=7
        fi

        echo "$condition" "$temp" "$code"
    else
        echo '...'
    fi
']]

local update_widget = function(weather_data, stderr)
	awesome.emit_signal("daemon::weather", weather_data:gsub("\n", ""))
	-- naughty.notify({
	-- 	title = "stderr",
	-- 	text = stderr,
	-- })
end

local timer
timer = gears.timer({
	timeout = interval,
	call_now = true,
	autostart = true,
	single_shot = false,
	callback = function()
		awful.spawn.easy_async_with_shell("date -r " .. file .. " +%s", function(last_update, _, _, exit_code)
			if exit_code == 1 then
				awful.spawn.easy_async_with_shell(script .. " | tee " .. file, function(stdout, stderr)
					update_widget(stdout, stderr)
				end)
				return
			end

			local diff = os.time() - tonumber(last_update)
			if diff >= interval then
				awful.spawn.easy_async_with_shell(script .. " | tee " .. file, function(stdout)
					update_widget(stdout)
				end)
			else
				awful.spawn.easy_async_with_shell("cat " .. file, function(stdout)
					update_widget(stdout)
				end)

				timer:stop()
				gears.timer.start_new(interval - diff, function()
					awful.spawn.easy_async_with_shell("cat " .. file, function(stdout)
						update_widget(stdout)
					end)
					timer:again()
					return false
				end)
			end
		end)
	end,
})
