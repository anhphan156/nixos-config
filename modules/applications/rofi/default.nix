{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    cyanea.desktopApp.rofi = {
      enable = lib.mkEnableOption "Enable Rofi";

      defaultConfig = lib.mkOption {
        description = "Default config for rofi";
        readOnly = true;
        type = lib.types.path;
        default =
          if config.cyanea.graphical.hyprland.enable
          then config.dotfiles.rofiWayland
          else config.dotfiles.rofiX;
      };
    };
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
