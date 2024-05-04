{ pkgs } : 

pkgs.writeShellScriptBin "music_retag" ''
    #!/usr/bin/env bash

    id3v2 -a "$2" -t "$3" $1
    mv $1 ~/data/Music/
''
