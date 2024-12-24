{
  writeShellApplication,
  rofi,
  kitty,
  tmux_code,
  basePath ? "~",
  ...
}:
writeShellApplication {
  name = "dev";
  runtimeInputs = [rofi kitty tmux_code];
  text = ''
    #!/usr/bin/env bash
    basepath=${basePath}

    # shellcheck disable=SC2012
    if project=$(ls $basepath | rofi -i -dmenu -p "Pick a Project"); then
      kitty --working-directory=$basepath/"$project" tmux_code "$project"
    fi
  '';
}
