{
  lib,
  config,
  pkgs,
  ...
}: let
  hyprlandCfg = config.cyanea.graphical.hyprland.enable;
in {
  options = {
    cyanea.desktopApp.rofi = {
      enable = lib.mkEnableOption "Enable Rofi";
    };
  };

  config = lib.mkIf (config.cyanea.graphical.gui.enable && config.cyanea.desktopApp.rofi.enable) {
    home-manager.users."${lib.user.name}".imports = [
      ({config, ...}: {
        # nixpkgs.overlays = [
        #   (_: prev: {
        #     rofi =
        #       if hyprlandCfg
        #       then prev.rofi-wayland
        #       else prev.rofi;
        #   })
        # ];
        home.packages = [pkgs.rofi-wayland];
        xdg.configFile."rofi/".source = config.lib.file.mkOutOfStoreSymlink "${pkgs.myDotfiles}/share/rofi";
      })
    ];
  };
}
