{
  writeShellApplication,
  rofi,
  rofiConfig,
  kitty,
  tmux_code,
  basePath ? "~",
  symlinkJoin,
  fzf,
  formats,
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

      if project=$(ls $basepath | rofi -i -dmenu -p "Pick a Project" -config ${rofiConfig}); then
        kitty --working-directory=$basepath/"$project" tmux_code "$project"
      fi
    '';
    excludeShellChecks = ["SC2012"];
  };

  guiDesktopEntry = Exec:
    (formats.ini {}).generate "dev.desktop" {
      "Desktop Entry" = {
        Type = "Application";
        Name = "Dev";
        Icon = "";
        Terminal = false;
        Categories = "";
        inherit Exec;
      };
    };

  tui = writeShellApplication {
    name = "devtui";
    runtimeInputs = [fzf tmux_code];
    text = ''
      base=${basePath}
      if dir=$(ls $base | fzf --preview "ls $base/{}"); then
      	cd $base/"$dir"
      	tmux_code "$dir"
      fi
    '';
    excludeShellChecks = ["SC2012"];
  };
in
  symlinkJoin {
    name = "spawn_projects";
    paths = [tui] ++ lib.optionals guiEnabled [gui];
    postBuild = lib.strings.optionalString guiEnabled ''
      mkdir -p $out/share/applications
      ln -s ${guiDesktopEntry "${gui}/bin/dev"} $out/share/applications/dev.desktop
    '';
  }
