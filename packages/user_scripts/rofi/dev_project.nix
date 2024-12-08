{
  writeShellScriptBin,
  basePath ? "~",
  ...
}:
writeShellScriptBin "dev" ''
  #!/usr/bin/env bash
  basepath=${basePath}
  project=`ls $basepath | rofi -i -dmenu -p "Pick a Project"`

  if [ $? -eq 0 ]; then
    kitty --working-directory=$basepath/$project tmux_code $project
  fi
''
