{
  lib,
  config,
  ...
}: let
  waybar_path = "${config.cyanea.dotfilesPath}/config/waybar/style.css";
in {
  options = {
    cyanea.graphical.waybar.enable = lib.mkEnableOption "Enable waybar";
  };

  config = lib.mkIf (config.cyanea.graphical.gui.enable && config.cyanea.graphical.hyprland.enable && config.cyanea.graphical.waybar.enable) {
    home-manager.users."${lib.user.name}" = {config, ...}: {
      programs.waybar = {
        enable = true;
        systemd.enable = true;
        settings = {
          mainBar = {
            layer = "top";
            position = "top";
            height = 30;
            margin-top = 10;
            output = [
              "DP-1"
              #"DP-3"
              #"HDMI-A-1"
            ];
            modules-left = [
              "hyprland/workspaces"
              "tray"
            ];
            modules-right = [
              "network"
              "temperature"
              "cpu"
              "memory"
              "clock"
            ];

            tray = {
              spacing = 10;
            };

            network = {
              tooltip = false;
              format-wifi = "{essid} {ipaddr}";
              format-ethernet = "{ipaddr}";
            };

            cpu = {
              tooltip = false;
            };
          };
        };
      };

      xdg.configFile = {
        "waybar/style.css".source = config.lib.file.mkOutOfStoreSymlink waybar_path;
      };
    };
  };
}
