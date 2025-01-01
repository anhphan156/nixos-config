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
    defaultSession = lib.mkOption {
      description = "sddm default session";
      type = lib.types.str;
      default =
        if cfg.awesome.enable
        then "none+awesome"
        else if cfg.xmonad.enable
        then "none+xmonad"
        else "hyprland";
    };
  };

  config = lib.mkIf cfg.gui.enable {
    environment.systemPackages = with pkgs; [
      libsForQt5.qt5.qtgraphicaleffects
      libsForQt5.qt5.qtquickcontrols2
    ];
    services.displayManager = {
      sddm.enable = true;
      sddm.theme = lib.mkForce "${pkgs.callPackage (inputs.self + /packages/MarianArlt-sddm-sugar-dark) {}}";
      sddm.wayland.enable = lib.mkIf cfg.hyprland.enable true;
      inherit (cfg.sddm) defaultSession;
      autoLogin = {
        enable = cfg.sddm.autoLogin.enable;
        user = lib.user.name;
      };
    };
  };
}
