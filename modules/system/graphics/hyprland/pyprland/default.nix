{
  config,
  user,
  lib,
  ...
}: let
  pyprland_path = "${config.cyanea.user.dotfilesPath}/config/hypr/pyprland.toml";
in {
  options = {
    cyanea.graphical.hyprland.pyprland.enable = lib.mkEnableOption "Enable pyprland";
  };

  config = lib.mkIf (with config.cyanea.graphical; (gui.enable && hyprland.enable && hyprland.pyprland.enable)) {
    home-manager.users."${user.name}" = {config, ...}: {
      xdg.configFile = {
        "hypr/pyprland.toml".source = config.lib.file.mkOutOfStoreSymlink pyprland_path;
      };
    };
  };
}
