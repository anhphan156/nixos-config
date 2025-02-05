{
  lib,
  config,
  inputs,
  ...
}: {
  options = {
    cyanea.desktopApp.rofi = {
      enable = lib.mkEnableOption "Enable Rofi";
    };
  };

  config = lib.mkIf (config.cyanea.graphical.gui.enable && config.cyanea.desktopApp.rofi.enable) {
    home-manager.users."${lib.user.name}" = import "${inputs.self}/modules/home-manager/dotfiles/rofi";
  };
}
