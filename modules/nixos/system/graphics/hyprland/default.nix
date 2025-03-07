{
  lib,
  config,
  ...
}: let
  cfg = config.cyanea.graphical;
in {
  options = {
    cyanea.graphical.hyprland = {
      enable = lib.mkEnableOption "Enable hyprland";
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

    programs.hyprland = {
      enable = true;
    };

    home-manager.users."${lib.user.name}" = {
      wayland.windowManager.hyprland = {
        enable = true;
        settings = {
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
            # sensitivity = "-0.9";
            sensitivity = "0.0";
            touchpad = lib.mkIf config.cyanea.system.laptop.enable {
              natural_scroll = true;
              middle_button_emulation = true;
            };
          };

          gestures = {
            workspace_swipe = true;
          };

          dwindle = {
            pseudotile = true;
          };

          windowrulev2 = [
            "opacity 1.0 override 1.0 override,class:(firefox)"
            "opacity 1.0 override 1.0 override,class:(librewolf)"
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

            "blur,^(ewwblur)$"
          ];
        };
      };
    };
  };
}
