{ pkgs, lib, config, inputs, user, ... }:
{
    imports = [
        ./bind.nix
    ];

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
                };
            };
        };
    };
}
