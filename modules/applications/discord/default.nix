{
  lib,
  config,
  user,
  pkgs,
  ...
}: {
  options = {
    cyanea.desktopApp.discord.enable = lib.mkEnableOption "Enable Discord";
  };

  config = lib.mkIf (config.cyanea.desktopApp.discord.enable && config.cyanea.graphical.gui.enable) {
    home-manager.users."${user.name}".home.packages = with pkgs; [
      discord
    ];
  };
}
