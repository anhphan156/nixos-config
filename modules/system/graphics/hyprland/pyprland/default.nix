{
  config,
  user,
  lib,
  ...
}: 
let
	pyprland_path = "${config.dotfilesPath}/config/hypr/pyprland.toml";
in
{
  options = {
    pyprland.enable = lib.mkEnableOption "Enable pyprland";
  };

  config = lib.mkIf (config.gui.enable && config.hyprland.enable && config.pyprland.enable) {
    home-manager.users."${user.name}" = {config, ...}: {
      xdg.configFile = {
        "hypr/pyprland.toml".source = config.lib.file.mkOutOfStoreSymlink pyprland_path;
      };
    };
  };
}
