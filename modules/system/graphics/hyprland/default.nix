{
  pkgs,
  lib,
  config,
  inputs,
  user,
  rootPath,
  ...
}: {
  imports = [
    ./bind.nix
    ../waybar
    ./pyprland
    ../mako
  ];

  options = {
    hyprland.enable = lib.mkEnableOption "Enable hyprland";
  };

  config = lib.mkIf (config.hyprland.enable && config.gui.enable) {
    mako.enable = lib.mkForce true;
    pyprland.enable = lib.mkForce true;
    rofi.enable = lib.mkForce true;
    pipewire.enable = lib.mkForce true;

    environment.systemPackages = with pkgs; [
      polkit
      xdg-desktop-portal-hyprland
      xwayland
      libnotify
      pyprland
      grim
      slurp
      wl-clipboard
      wireplumber # streaming stuff
      swww
      (import (rootPath + /packages/user_scripts/swww_triple_monitor.nix) {inherit pkgs;})
      (import (rootPath + /packages/user_scripts/swww_single_monitor.nix) {inherit pkgs;})
    ];

    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    };

    home-manager.users."${user.name}" = {
      wayland.windowManager.hyprland = let
        autostart = pkgs.pkgs.writeShellScriptBin "start" ''
          pypr &

          swww init &
          sleep 1
          swww img "${config.users.users.backspace.home}/dotfiles/config/kitty/firefly.jpg" &
        '';
      in {
        enable = true;
        settings = {
          exec-once = [
            "${autostart}/bin/start"
            "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
            "eww daemon"
          ];

          general = {
            border_size = "3";
            "col.active_border" = "rgb(ce3454) rgb(82d5ff) 45deg";
          };

          decoration = {
            shadow_offset = "5 5";
            "col.shadow" = "rgba(00000099)";
            rounding = "10";
            active_opacity = "0.9";
            inactive_opacity = "0.6";

            blur = {
              enabled = true;
              ignore_opacity = true;
              size = "8";
              passes = "2";
              xray = true;
            };
          };

          input = {
            #follow_mouse = "1";
            sensitivity = "0.0";
          };

          monitor = [
            "HDMI-A-1,1920x1080,0x0,1"
            "DP-1,1920x1080@144,1920x0,1,bitdepth,10"
            "DP-3,3840x2160,3840x0,1"
          ];

          windowrulev2 = [
            "opacity 1.0 override 1.0 override,class:(firefox)"
          ];

          layerrule = [
            "animation popin 20%, ^(rofi)$"
            "blur, ^(rofi)$"
            "ignorezero, ^(rofi)$"
            "dimaround, ^(rofi)$"
          ];

          workspace = [
            "2, monitor:DP-1"
            "3, monitor:DP-1"
            "4, monitor:DP-1"
            "5, monitor:HDMI-A-1"
          ];
        };
      };
    };
  };
}
