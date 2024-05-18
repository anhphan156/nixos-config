{ pkgs, lib, config, inputs, user, rootPath, ... }:
{
    imports = [
        ./bind.nix
        ../waybar
    ];

    options = {
        hyprland.enable = lib.mkEnableOption "Enable hyprland";
    };

    config = lib.mkIf (config.hyprland.enable && config.gui.enable) {

        environment.systemPackages = with pkgs; [
            polkit
            xdg-desktop-portal-hyprland
            xwayland
            dunst libnotify
            pyprland
        ];

        programs.hyprland = {
            enable = true;
            package = inputs.hyprland.packages."${pkgs.system}".hyprland;
        };

        home-manager.users."${user.name}" = {
            wayland.windowManager.hyprland = {
                enable = true;
                settings = {
                    exec-once = ''${rootPath + /packages/user_scripts/hyprland_startup.nix}/bin/start'';

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
                        };
                    };

                    input = {
                        #follow_mouse = "1";
                    };

                    monitor = [
                        "HDMI-A-1,1920x1080,0x0,1"
                        "DP-1,1920x1080@144,1920x0,1"
                        "DP-3,3840x2160,3840x0,1"
                    ];

                    windowrulev2 = [
                        "opacity 1.0 override 1.0 override,class:(firefox)"
                    ];

                    layerrule = [
                        "animation slidefade 20%, rofi"
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
