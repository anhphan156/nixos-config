{
  config,
  user,
  lib,
	rootPath,
  ...
}: {
  options = {
    pyprland.enable = lib.mkEnableOption "Enable pyprland";
  };

  config = lib.mkIf (config.gui.enable && config.hyprland.enable && config.pyprland.enable) {
    home-manager.users."${user.name}" = {config, ...}:{
      xdg.configFile = {
        "hypr/pyprland.toml".source = config.lib.file.mkOutOfStoreSymlink (rootPath + /config/hypr/pyprland.toml);
      };
    };
  };
}
