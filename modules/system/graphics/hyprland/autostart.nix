{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.cyanea.graphical;

  swww_scripts = pkgs.callPackage (lib.user.path.root + /packages/user_scripts/swww_scripts.nix) {
    inherit (config.cyanea) wallpapers;
    inherit (cfg.hyprland.monitor) monitorList;
  };

  autostart = pkgs.writeShellScriptBin "start" ''
    pypr &

    eww daemon
    eww open bar
    eww open leftdock

    swww init &
    sleep 1
    ${swww_scripts}/bin/swww_sm
  '';
in {
  config = lib.mkIf (cfg.hyprland.enable && cfg.gui.enable) {
    home-manager.users."${lib.user.name}".wayland.windowManager.hyprland = {
      settings = {
        exec-once = [
          "${autostart}/bin/start"
          "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
          "wl-paste --watch cliphist store"
        ];
      };
    };
  };
}
