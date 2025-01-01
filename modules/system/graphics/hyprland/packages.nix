{
  pkgs,
  config,
  inputs,
  lib,
  ...
}: let
  cfg = config.cyanea.graphical;
in {
  config = lib.mkIf (cfg.hyprland.enable && cfg.gui.enable) {
    environment.systemPackages = with pkgs; [
      polkit
      xdg-desktop-portal-hyprland
      xwayland
      libnotify
      pyprland
      grim
      slurp
      wl-clipboard
      cliphist
      wtype
      wireplumber # streaming stuff
      swww
      (pkgs.callPackage (inputs.self + /packages/user_scripts/swww_scripts.nix) {
        inherit (cfg.hyprland.monitor) monitorList resolutionList;
      })
    ];
  };
}
