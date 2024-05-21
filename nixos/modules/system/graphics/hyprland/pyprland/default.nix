{
  config,
  user,
  lib,
  ...
}: {
  options = {
    pyprland.enable = lib.mkEnableOption "Enable pyprland";
  };

  config = lib.mkIf (config.gui.enable && config.hyprland.enable && config.pyprland.enable) {
    home-manager.users."${user.name}" = {config, ...}: let
      pyprland_path = "${config.home.homeDirectory}/dotfiles/config/hypr/pyprland.toml";
    in {
      xdg.configFile = {
        "hypr/pyprland.toml".source = config.lib.file.mkOutOfStoreSymlink pyprland_path;
      };
    };
  };
}
