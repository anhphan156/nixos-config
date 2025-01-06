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
    # environment.systemPackages = with pkgs; [
    #   libsForQt5.qt5.qtgraphicaleffects
    #   libsForQt5.qt5.qtquickcontrols2
    # ];
    services.displayManager = {
      sddm.enable = true;
      sddm.package = pkgs.kdePackages.sddm;
      # sddm.theme = lib.mkForce "${pkgs.callPackage (inputs.self + /packages/MarianArlt-sddm-sugar-dark) {}}"; # this theme probably uses sddm qt5 instead of qt6, so change sddm.package to an appropriate package
      sddm.theme = lib.mkForce "${pkgs.callPackage (inputs.self + /packages/sddm-astronaut-theme) {}}";
      sddm.wayland.enable = lib.mkIf cfg.hyprland.enable true;
      sddm.extraPackages = with pkgs; [
        kdePackages.qtmultimedia
      ];
      inherit (cfg.sddm) defaultSession;
      autoLogin = {
        enable = cfg.sddm.autoLogin.enable;
        user = lib.user.name;
      };
    };
  };
}
