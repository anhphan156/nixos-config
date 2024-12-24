{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    cyanea.desktopApp.rofi.enable = lib.mkEnableOption "Enable Rofi";
  };

  config = lib.mkIf (config.cyanea.graphical.gui.enable && config.cyanea.desktopApp.rofi.enable) {
    home-manager.users."${lib.user.name}".imports = [
      ({config, ...}: {
        home.packages = [pkgs.rofi];
        xdg.configFile."rofi/".source = config.lib.file.mkOutOfStoreSymlink "${pkgs.myDotfiles}/share/rofi";
      })
    ];
  };
}
