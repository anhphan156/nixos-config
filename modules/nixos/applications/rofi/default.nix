{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    cyanea.desktopApp.rofi = {
      enable = lib.mkEnableOption "Enable Rofi";
    };
  };

  config = lib.mkIf (config.cyanea.graphical.gui.enable && config.cyanea.desktopApp.rofi.enable) {
    home-manager.users."${lib.user.name}" = {
      home.packages = [pkgs.rofi];
      dotfiles.rofi.background = "${pkgs.wallpapers}/single/firefly_zzz.jpg";
      xdg.configFile."rofi/".source = config.dotfiles.rofi.config;
    };
  };
}
