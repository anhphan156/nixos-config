{
  user,
  config,
  lib,
  ...
}: {
  config = lib.mkIf (with config.cyanea.graphical; (gui.enable && hyprland.enable)) {
    home-manager.users."${user.name}" = {config, ...}: let
      screenshotPath = "${config.home.homeDirectory}/data/Pictures/screenshots/$(date +'%s_grim.png')";
    in {
      wayland.windowManager.hyprland.settings = {
        "$mod" = "SUPER";
        # mod: SUPER SUPERSHIFT CTRL_SHIFT
        # key symbols: https://github.com/xkbcommon/libxkbcommon/blob/master/include/xkbcommon/xkbcommon-keysyms.h
        bind =
          [
            # spawn
            "$mod, RETURN, exec, kitty"
            "$mod, W, killactive"
            "ALT, SPACE, execr, rofi -show run"

            # window control
            "$mod, F, togglefloating"
            "$mod, M, fullscreen, 1"

            # alt tab
            "ALT, TAB, cyclenext"
            "ALT, TAB, bringactivetotop"

            # scratchpad
            "$mod, P, exec, pypr toggle kitty"
            "SUPERSHIFT, 1, exec, pypr toggle nemo"
            "SUPERSHIFT, 2, exec, pypr toggle obsidian"
            "SUPERSHIFT, 9, exec, pypr toggle pavucontrol"

            # screenshots
            '', Print, exec, grim -g "$(slurp -d)" ${screenshotPath}''
            "SUPERSHIFT, S, exec, grim -g \"$(slurp -d)\" - | wl-copy"

            #misc
            "SUPERSHIFT, W, exec, swww_sm"
          ]
          ++ map (x: "$mod, ${toString x}, workspace, ${toString x}") [1 2 3 4 5 6];

        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];

        bindel = [
          ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ];
        bindl = [
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ];
      };
    };
  };
}
