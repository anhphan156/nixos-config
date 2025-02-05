{
  writeShellApplication,
  rofi,
  rofiConfig,
  awesome,
  ...
}:
writeShellApplication {
  name = "awesome_layout_switch";
  runtimeInputs = [rofi awesome];
  text = ''
    #!/usr/bin/env bash

    layout=$(echo "tile
    floating
    tile.left
    tile.bottom
    tile.top
    fair
    fair.horizontal
    spiral
    spiral.dwindle
    max
    max.fullscreen
    magnifier
    corner.nw
    corner.ne
    corner.sw
    corner.se" | rofi -i -dmenu -config ${rofiConfig})

    awesome-client "local awful = require('awful'); awful.layout.set(awful.layout.suit.$layout);"
  '';
}
