{
  writeShellScriptBin,
  basePath ? "~",
  ...
}:
writeShellScriptBin "dev_fzf" ''
  #!/usr/bin/env bash

  base=${basePath}
  dir=$(ls $base | fzf --preview "ls $base/{}")
  if [ $? -eq 0 ]; then
  	cd $base/$dir
  	tmux_code $dir
  fi
''
