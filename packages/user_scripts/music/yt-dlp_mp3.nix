{pkgs}:
pkgs.writeShellScriptBin "music_download" ''
  #!/usr/bin/env bash

	output=~/data/Music/$2.mp3

  ${pkgs.yt-dlp}/bin/yt-dlp -x --audio-format mp3 -o $output $1

	if [ $? -eq 0 ]; then
		${pkgs.id3v2}/bin/id3v2  -a "$3" -t "$4" $output
	else
		echo "Failed to download from yt"
	fi
''
