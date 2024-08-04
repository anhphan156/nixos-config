{ pkgs } : pkgs.writeShellScriptBin "dev" ''
#!/usr/bin/env bash
basepath=~/data/dev
project=`ls $basepath | rofi -dmenu`

if [ -e "$basepath/$project/flake.nix" ]; then
	kitty --working-directory=$basepath/$project nix develop
else
	kitty --working-directory=$basepath/$project tmux_code $project
fi
''
