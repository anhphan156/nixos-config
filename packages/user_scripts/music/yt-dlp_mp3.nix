{pkgs}:
pkgs.writeShellScriptBin "music_download" ''
  #!/usr/bin/env bash

  ${pkgs.yt-dlp}/bin/yt-dlp -x --audio-format mp3 -o "~/Downloads/$2.%(ext)s" $1
''
