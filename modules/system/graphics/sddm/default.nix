{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: let
  cfg = config.cyanea.graphical;
in {
  options.cyanea.graphical.sddm = {
    autoLogin.enable = lib.mkOption {
      description = "enable auto login";
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf cfg.gui.enable {
    environment.systemPackages = with pkgs; [
      libsForQt5.qt5.qtgraphicaleffects
      libsForQt5.qt5.qtquickcontrols2
    ];
    services.displayManager = {
      sddm.enable = true;
      sddm.catppuccin.enable = false;
      # sddm.catppuccin.assertQt6Sddm = false;
      sddm.theme = lib.mkForce "${pkgs.callPackage (inputs.src + /packages/MarianArlt-sddm-sugar-dark) {inherit (config.cyanea) wallpapers;}}";
      sddm.wayland.enable = lib.mkIf cfg.hyprland.enable true;
      defaultSession =
        if cfg.awesome.enable
        then "none+awesome"
        else if cfg.xmonad.enable
        then "none+xmonad"
        else "hyprland";
      autoLogin = {
        enable = cfg.sddm.autoLogin.enable;
        user = "backspace";
      };
    };
  };
}
