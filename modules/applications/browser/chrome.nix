{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.cyanea;
in {
  options = {
    cyanea.desktopApp.googlechrome.enable = lib.mkEnableOption "Enable Google Chrome";
  };

  config = lib.mkIf (cfg.graphical.gui.enable && cfg.desktopApp.googlechrome.enable) {
    home-manager.users."${lib.user.name}".home.packages = with pkgs; [
      google-chrome
    ];
  };
}
