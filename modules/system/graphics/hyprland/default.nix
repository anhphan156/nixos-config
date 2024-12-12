{
  pkgs,
  lib,
  config,
  inputs,
  user,
  ...
}: let
  cfg = config.cyanea.graphical;
in {
  options = {
    cyanea.graphical.hyprland = {
      enable = lib.mkEnableOption "Enable hyprland";
      monitor = lib.mkOption {
        default = [",preferred,auto,1"];
        type = lib.types.listOf lib.types.str;
        description = "List of monitors";
      };
      workspace = lib.mkOption {
        default = [];
        type = lib.types.listOf lib.types.str;
        description = "List of workspace";
      };
    };
  };

  config = lib.mkIf (cfg.hyprland.enable && cfg.gui.enable) {
    cyanea = {
      desktopApp.rofi = lib.enabled;
      graphical = {
        eww = lib.enabled;
        mako = lib.enabled;
        hyprland.pyprland = lib.enabled;
      };
    };

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
      (pkgs.callPackage
        (user.path.root + /packages/user_scripts/swww_triple_monitor.nix)
        {wallpaperPath = "$HOME/data/Pictures/legacy/Wallpapers/showcase/";})
      (pkgs.callPackage
        (user.path.root + /packages/user_scripts/swww_single_monitor.nix)
        {wallpaperPath = "$HOME/data/Pictures/legacy/Wallpapers/dual";})
    ];

    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    };

    home-manager.users."${user.name}" = {
      wayland.windowManager.hyprland = let
        autostart = pkgs.pkgs.writeShellScriptBin "start" ''
          pypr &

          eww daemon
          eww open bar
          eww open leftdock

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
            "wl-paste --watch cliphist store"
          ];

          general = {
            border_size = "3";
            "col.active_border" = "rgb(ce3454) rgb(82d5ff) 45deg";
          };

          decoration = {
            # drop_shadow = "yes";
            # shadow_range = "300";
            # shadow_render_power = "4";
            # "col.shadow" = "rgba(1a1a1aaf)";
            # shadow_offset = "0 40";
            # shadow_scale = "0.9";
            rounding = "10";
            active_opacity = "0.75";
            inactive_opacity = "0.4";

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
            touchpad = lib.mkIf config.cyanea.system.laptop.enable {
              natural_scroll = true;
              middle_button_emulation = true;
            };
          };

          monitor = config.cyanea.graphical.hyprland.monitor;
          workspace = config.cyanea.graphical.hyprland.workspace;

          windowrulev2 = [
            "opacity 1.0 override 1.0 override,class:(firefox)"
            "opacity 1.0 override 1.0 override,class:(Google-chrome)"
            "opacity 1.0 override 1.0 override,class:(virt-manager)"
            "opacity 1.0 override 1.0 override,class:(vesktop)"
            "opacity 1.0 override 1.0 override,title:(GlslViewer)"

            "float,title:(GLFW)"
            "animation slidefade 20%,title:(GLFW)"
          ];

          layerrule = [
            "animation popin 20%, ^(rofi)$"
            "blur, ^(rofi)$"
            "ignorezero, ^(rofi)$"
            "dimaround, ^(rofi)$"
          ];
        };
      };
    };
  };
}
