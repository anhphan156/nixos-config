{
  writeShellScriptBin,
  musicPath,
  yt-dlp,
  id3v2,
  ...
}:
writeShellScriptBin "music_download" ''
   #!/usr/bin/env bash

  output=${musicPath}/$2.mp3

   ${yt-dlp}/bin/yt-dlp -x --audio-format mp3 -o $output $1

  if [ $? -eq 0 ]; then
  	${id3v2}/bin/id3v2  -a "$3" -t "$4" $output
  else
  	echo "Failed to download from yt"
  fi
''
