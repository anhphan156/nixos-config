{ pkgs, config } : 

pkgs.writeShellScriptBin "start" ''
    #!/usr/bin/env bash

    waybar &
    ${swww}/bin/swww init &
    sleep 1
    ${swww}/bin/swww img ${config.users.users.backspace.home + /dotfiles/config/kitty/firefly.jpg} &
''
