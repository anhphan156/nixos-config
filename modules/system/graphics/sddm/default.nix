{
  lib,
  config,
  pkgs,
  rootPath,
  ...
}: {
  config = {
    environment.systemPackages = with pkgs; [
      libsForQt5.qt5.qtgraphicaleffects
      libsForQt5.qt5.qtquickcontrols2
    ];
    services.displayManager = {
      sddm.enable = true;
      sddm.theme = "${import (rootPath + /packages/MarianArlt-sddm-sugar-dark) {inherit pkgs;}}";
      sddm.wayland.enable = lib.mkIf config.hyprland.enable true;
      defaultSession =
        if config.awesome.enable
        then "none+awesome"
        else "hyprland";
      #autoLogin = {
      #    enable = true;
      #    user = "backspace";
      #};
    };
  };
}
