{ user, config, lib, ... }: 
{
    config = lib.mkIf (config.gui.enable && config.hyprland.enable) {
        home-manager.users."${user.name}" = { config, ...} :
        let
            screenshotPath = "${config.home.homeDirectory}/data/Pictures/screenshots/$(date +'%s_grim.png')";
        in
        {
            wayland.windowManager.hyprland.settings = 
            {
                "$mod" = "SUPER";
                # mod: SUPER SUPERSHIFT CTRL_SHIFT
                # key symbols: https://github.com/xkbcommon/libxkbcommon/blob/master/include/xkbcommon/xkbcommon-keysyms.h 
                bind = [
                    # spawn
                    "$mod, RETURN, exec, kitty"
                    "$mod, W, killactive"
                    "ALT, SPACE, execr, rofi -show run"

                    # alt tab
                    "ALT, TAB, cyclenext"
                    "ALT, TAB, bringactivetotop"

                    # scratchpad
                    "$mod, P, exec, pypr toggle kitty"

                    # screenshots
                    '', Print, exec, grim -g "$(slurp -d)" ${screenshotPath}''
                    "SUPERSHIFT, S, exec, grim -g \"$(slurp -d)\" - | wl-copy"
                ] 
                ++ map (x: "$mod, ${toString x}, workspace, ${toString x}") [ 1 2 3 4 5 6 ];

                bindm = [
                    "$mod, mouse:272, movewindow"
                    "$mod, mouse:273, resizewindow"
                ];
            };
        };
    };
}
