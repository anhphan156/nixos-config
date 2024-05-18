{ user, config, lib, ... }: 
{
    config = lib.mkIf (config.gui.enable && config.hyprland.enable) {
        home-manager.users."${user.name}".wayland.windowManager.hyprland.settings = {
            "$mod" = "SUPER";
            # mod: SUPER SUPERSHIFT CTRL_SHIFT
            # key symbols: https://github.com/xkbcommon/libxkbcommon/blob/master/include/xkbcommon/xkbcommon-keysyms.h 
            bind = [
                "$mod, RETURN, exec, kitty"
                "$mod, W, killactive"
                "ALT, SPACE, execr, rofi -show run"

                "ALT, TAB, cyclenext"
                "ALT, TAB, bringactivetotop"
            ] 
            ++ map (x: "$mod, ${toString x}, workspace, ${toString x}") [ 1 2 3 4 5 6 ];

            bindm = [
                "$mod, mouse:272, movewindow"
                "$mod, mouse:273, resizewindow"
            ];
        };
    };
}
