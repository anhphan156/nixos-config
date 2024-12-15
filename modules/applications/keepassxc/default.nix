{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    cyanea.desktopApp.keepassxc.enable = lib.mkEnableOption "Enable keepassxc";
  };

  config = lib.mkIf (config.cyanea.graphical.gui.enable && config.cyanea.desktopApp.keepassxc.enable) {
    home-manager = lib.install [
      pkgs.keepassxc
    ];
  };
}
