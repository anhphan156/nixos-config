#!/usr/bin/env bash

awesome-client "
    local naughty = require('naughty')
    naughty.notify({
        title='$1',
        text='$2'
    })
"
