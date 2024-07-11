{
  lib,
  config,
  pkgs,
  user,
  ...
}: let
  cfg = config.cyanea.graphical;
in {
  config = lib.mkIf cfg.gui.enable {
    environment.systemPackages = with pkgs; [
      libsForQt5.qt5.qtgraphicaleffects
      libsForQt5.qt5.qtquickcontrols2
    ];
    services.displayManager = {
      sddm.enable = true;
			sddm.catppuccin.enable = false;
			# sddm.catppuccin.assertQt6Sddm = false;
      sddm.theme = lib.mkForce "${import (user.rootPath + /packages/MarianArlt-sddm-sugar-dark) {inherit pkgs;}}";
      sddm.wayland.enable = lib.mkIf cfg.hyprland.enable true;
      defaultSession =
        if cfg.awesome.enable
        then "none+awesome"
        else if cfg.xmonad.enable
        then "none+xmonad"
        else "hyprland";
      autoLogin = {
        enable = true;
        user = "backspace";
      };
    };
  };
}
