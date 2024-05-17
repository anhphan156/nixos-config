{ pkgs, lib, config, inputs, user, ... }:
{
    options = {
        hyprland.enable = lib.mkEnableOption "Enable hyprland";
    };

    config = lib.mkIf (config.hyprland.enable && config.gui.enable) {

        environment.systemPackages = with pkgs; [
            polkit
            xdg-desktop-portal-hyprland
            xwayland
        ];

        programs.hyprland = {
            enable = true;
            package = inputs.hyprland.packages."${pkgs.system}".hyprland;
        };

        home-manager.users."${user.name}" = {
            wayland.windowManager.hyprland = {
                enable = true;
                settings = {
                    decoration = {
                        shadow_offset = "0 5";
                        "col.shadow" = "rgba(00000099)";
                    };
                    "$mod" = "SUPER";
                    bindm = [
                        "$mod, mouse:272, movewindow"
                        "$mod, mouse:273, resizewindow"
                        "$mod ALT, mouse:272, resizewindow"
                    ];
                };
            };
        };
    };
}
