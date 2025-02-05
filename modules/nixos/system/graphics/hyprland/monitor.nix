{
  lib,
  config,
  ...
}: let
  cfg = config.cyanea.graphical;
in {
  options = {
    cyanea.graphical.hyprland = {
      monitor = let
        inherit (lib.types) listOf str;
      in {
        monitorList = lib.mkOption {
          default = [""];
          type = listOf str;
          description = "List of monitors";
        };
        resolutionList = lib.mkOption {
          default = ["preferred,auto,1"];
          type = listOf str;
          description = "List of resolution";
        };
      };
    };
  };

  config = lib.mkIf (cfg.hyprland.enable && cfg.gui.enable) {
    home-manager.users."${lib.user.name}".wayland.windowManager.hyprland = {
      settings = let
        inherit (cfg.hyprland.monitor) monitorList resolutionList;
      in {
        monitor = lib.lists.zipListsWith (x: y: "${x},${y}") monitorList resolutionList;
      };
    };
  };
}
