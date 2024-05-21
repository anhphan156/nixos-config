{ pkgs } :

pkgs.writeShellScriptBin "swww_tm" ''
    #!/usr/bin/env bash

    wallpapers=$HOME/data/Pictures/legacy/Wallpapers/dual
    random=$(ls $wallpapers | shuf | head -1)
    random=$wallpapers/$random

    convert -crop 50%x100% $random /tmp/output.png

    swww img -o "DP-1" --transition-type center /tmp/output-1.png
    swww img -o "HDMI-A-1" --transition-type center /tmp/output-0.png
''
