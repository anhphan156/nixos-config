{
  writeShellApplication,
  rofi,
  rofiConfig,
  kitty,
  tmux_code,
  basePath ? "~",
  symlinkJoin,
  fzf,
  guiEnabled ? false,
  lib,
  ...
}: let
  gui = writeShellApplication {
    name = "dev";
    runtimeInputs = [rofi kitty tmux_code];
    text = ''
      #!/usr/bin/env bash
      basepath=${basePath}

      # shellcheck disable=SC2012
      if project=$(ls $basepath | rofi -i -dmenu -p "Pick a Project" -config ${rofiConfig}); then
        kitty --working-directory=$basepath/"$project" tmux_code "$project"
      fi
    '';
  };

  tui = writeShellApplication {
    name = "devtui";
    runtimeInputs = [fzf tmux_code];
    text = ''
      base=${basePath}
      # shellcheck disable=SC2012
      if dir=$(ls $base | fzf --preview "ls $base/{}"); then
      	cd $base/"$dir"
      	tmux_code "$dir"
      fi
    '';
  };
in
  symlinkJoin {
    name = "spawn_projects";
    paths = [tui] ++ lib.optionals guiEnabled [gui];
  }
