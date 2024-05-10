local naughty = require('naughty')

awesome.connect_signal('acpi::power_button', function() 
    naughty.notify({
        title = 'power button',
        text = 'pressed'
    })
end)
