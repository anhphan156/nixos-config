{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    cyanea.desktopApp.discord.enable = lib.mkEnableOption "Enable Discord";
  };

  config = lib.mkIf (config.cyanea.desktopApp.discord.enable && config.cyanea.graphical.gui.enable) {
    home-manager = lib.install (with pkgs; [
      discord
    ]);
  };
}
