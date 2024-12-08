{
  writeShellScriptBin,
  wallpaperPath,
  ...
}:
writeShellScriptBin "swww_tm" ''
  #!/usr/bin/env bash

  wallpapers=${wallpaperPath}
  random=$(ls $wallpapers | shuf | head -1)
  random=$wallpapers/$random

  convert -crop 50%x100% $random /tmp/output.png

  swww img -o "DP-1" --transition-type center /tmp/output-1.png
  swww img -o "DP-3" --transition-type center /tmp/output-0.png
''
