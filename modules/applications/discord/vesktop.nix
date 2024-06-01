{
  lib,
  config,
  user,
  pkgs,
  ...
}: {
  options = {
    cyanea.desktopApp.vesktop.enable = lib.mkEnableOption "Enable Vesktop";
  };

  config = lib.mkIf (config.cyanea.desktopApp.vesktop.enable && config.cyanea.graphical.gui.enable) {
    home-manager.users."${user.name}".home.packages = with pkgs; [
      vesktop
    ];
  };
}
