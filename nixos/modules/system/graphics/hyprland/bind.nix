{ user, config, lib, ... }: 
{
    config = lib.mkIf (config.gui.enable && config.hyprland.enable) {
        home-manager.users."${user.name}".wayland.windowManager.hyprland.settings = {
            "$mod" = "SUPER";
            bind = [
                "$mod, Q,exec,kitty"
                "$mod, F,exec,firefox"
            ];
            bindm = [
                "$mod, mouse:272, movewindow"
                "$mod, mouse:273, resizewindow"
            ];
        };
    };
}
