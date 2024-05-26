{pkgs}:
pkgs.writeShellScriptBin "swww_sm" ''
  #!/usr/bin/env bash

  wallpapers=$HOME/data/Pictures/legacy/Wallpapers/showcase/
  random=$(ls $wallpapers | shuf | head -1)
  random=$wallpapers/$random

  swww img -o "DP-1" --transition-type center $random
  swww img -o "DP-3" --transition-type center $random
  swww img -o "HDMI-A-1" --transition-type center $random
''
