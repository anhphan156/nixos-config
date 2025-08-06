{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: let
  cfg = config.cyanea.graphical;

  swww_scripts = pkgs.callPackage (inputs.self + /packages/scripts/media/swww_scripts.nix) {
    inherit (cfg.hyprland.monitor) monitorList resolutionList;
  };

  autostart = pkgs.writeShellScriptBin "start" ''
    pypr &

    swww-daemon &
    sleep 1
    ${swww_scripts}/bin/swww_sm
  '';
in {
  config = lib.mkIf (cfg.hyprland.enable && cfg.gui.enable) {
    home-manager.users."${lib.user.name}".wayland.windowManager.hyprland = {
      settings = {
        exec-once = [
          "${pkgs.myEwwScripts}/bin/ewwinit"
          "${lib.getExe autostart}"
          "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
          # "wl-paste --watch cliphist store"
        ];
      };
    };
  };
}
