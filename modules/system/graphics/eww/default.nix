{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  # TODO make a c program to keep track of what window is open and closed with hyprland ipc and emits an output for (deflisten)
  leftdockscript = pkgs.writeShellScriptBin "leftdockcheck" ''
    #!/usr/bin/env bash

    eww update revealdock=true

    hyprctl clients | grep "class: firefox"

    if [[ $? -eq 0 ]]; then
      eww update icon1=true
    else
      eww update icon1=false
    fi
  '';
in {
  options.cyanea.graphical.eww.enable = lib.mkEnableOption "Enable Eww";

  config = lib.mkIf config.cyanea.graphical.eww.enable {
    environment.systemPackages = with pkgs; [
      eww
      leftdockscript
    ];
    home-manager.users."${lib.user.name}" = {
      # programs.eww = {
      #   enable = true;
      #   configDir = dotfilesPath + /config/eww;
      # };
      xdg.configFile = {
        "eww/".source = inputs.eww-config.packages.${pkgs.system}.default;
      };
    };
  };
}
