{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  workspace_list = builtins.concatLists config.cyanea.graphical.hyprland.monitor.workspaceList;

  keepassrofi = pkgs.callPackage (inputs.self + /packages/user_scripts/rofi/keepassxc.nix) {
    rofiConfig = config.dotfiles.rofi.prompt;
  };

  screenshots = pkgs.callPackage (inputs.self + /packages/user_scripts/media/screenshots.nix) {};
  screenshotPath = "${lib.user.path.screenshot}/$(date +'%s_grim.png')";
in {
  config = lib.mkIf (with config.cyanea.graphical; (gui.enable && hyprland.enable)) {
    home-manager.users."${lib.user.name}" = {
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

            # rofi
            "$mod, C, execr, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
            "$mod, L, execr, cat ~/data/links.txt | rofi -i -dmenu | xargs wtype"
            "$mod, T, execr, tmux ls | rofi -i -dmenu -p \"Session\" | awk -F: '{print $1}' | xargs -I {} kitty tmux attach -t {}"
            "$mod, K, execr, ${lib.getExe keepassrofi}"

            # window control
            "$mod, F, togglefloating"
            "$mod, M, fullscreen, 1"

            # alt tab
            "ALT, TAB, cyclenext"
            "ALT, TAB, bringactivetotop"
            "$mod, TAB, focuscurrentorlast"

            # scratchpad
            "$mod, P, exec, pypr toggle kitty"

            # screenshots
            '', Print, exec, grim -g "$(slurp -d)" ${screenshotPath}''
            "SUPERSHIFT, S, exec, ${lib.getExe screenshots}"

            #misc
            "SUPERSHIFT, W, exec, swww_sm"
          ]
          ++ map (x: "$mod, ${toString x}, workspace, ${toString x}") workspace_list
          ++ map (x: "SUPERSHIFT, ${toString x}, movetoworkspacesilent, ${toString x}") workspace_list;

        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];

        bindel = [
          ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ", XF86MonBrightnessUp, exec, xbacklight -inc 5"
          ", XF86MonBrightnessDown, exec, xbacklight -dec 5"
        ];
        bindl = [
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ];
      };
    };
  };
}
