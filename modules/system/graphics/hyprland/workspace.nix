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
        inherit (lib.types) listOf int;
      in {
        workspaceList = lib.mkOption {
          default = [[1 2 3] [4 5 6]];
          type = listOf <| listOf int;
          description = "List of workspace";
        };
      };
    };
  };

  config = lib.mkIf (cfg.hyprland.enable && cfg.gui.enable) {
    home-manager.users."${lib.user.name}".wayland.windowManager.hyprland = {
      settings = let
        inherit (cfg.hyprland.monitor) monitorList workspaceList;
      in {
        workspace = [
          "1, border:0, rounding:0, gapsin:0, gapsout:0"
        ] ++ (builtins.concatLists <| lib.lists.zipListsWith (x: y: y |> map (z: "${toString z},monitor:${x}")) monitorList workspaceList);
      };
    };
  };
}
