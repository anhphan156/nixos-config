{
  config,
  lib,
  user,
  pkgs,
  ...
}: let
  eww_path = "${config.cyanea.user.dotfilesPath}/config/eww";

  leftdockscript = pkgs.writeShellScriptBin "leftdockcheck" ''
    #!/usr/bin/env bash

    eww update revealdock=true

    hyprctl clients | grep "class: firefox"

    if [[ $? -eq 0 ]]; then
      eww update test=blue
    else
      eww update test=red
    fi
  '';
in {
  options.cyanea.graphical.eww.enable = lib.mkEnableOption "Enable Eww";

  config = lib.mkIf config.cyanea.graphical.eww.enable {
    environment.systemPackages = with pkgs; [
      eww
      leftdockscript
    ];
    home-manager.users."${user.name}" = {config, ...}: {
      # programs.eww = {
      #   enable = true;
      #   configDir = dotfilesPath + /config/eww;
      # };
      xdg.configFile = {
        "eww/".source = config.lib.file.mkOutOfStoreSymlink eww_path;
      };
    };
  };
}
