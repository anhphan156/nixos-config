{
  writeShellApplication,
  wrapDesktopItem,
  rofi,
  rofiConfig,
  kitty,
  tmux_code,
  basePath ? "~",
  ...
}:
wrapDesktopItem { } <| writeShellApplication {
  name = "Dev";
  runtimeInputs = [rofi kitty tmux_code];
  text = ''
    #!/usr/bin/env bash
    basepath=${basePath}

    if project=$(ls $basepath | rofi -i -dmenu -p "Pick a Project" -config ${rofiConfig}); then
      kitty --working-directory=$basepath/"$project" tmux_code "$project"
    fi
  '';
  excludeShellChecks = ["SC2012"];
}
