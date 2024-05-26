{
  user,
  lib,
  config,
  rootPath,
  ...
}: let
  isHyprland = config.hyprland.enable;
in {
  options = {
    rofi.enable = lib.mkEnableOption "Enable Rofi";
  };

  config = lib.mkIf (config.gui.enable && config.rofi.enable) {
    home-manager.users."${user.name}".imports = [
      ({
        config,
        lib,
        pkgs,
        ...
      }: {
        home.packages = [
          (
            if isHyprland
            then pkgs.rofi-wayland
            else pkgs.rofi
          )
        ];
        xdg.configFile."rofi/".source = config.lib.file.mkOutOfStoreSymlink (rootPath + /config/rofi);

        programs.rofi = {
          enable = false;
          package = lib.mkIf isHyprland pkgs.rofi-wayland;
          plugins = with pkgs; [
            rofi-calc
            rofi-emoji
          ];
          extraConfig = {
            modes = "window,drun,run,combi";
            combi-modes = "window,drun,run";
            font = "AnkaCoder 15";

            display-window = "";
            display-run = "♥";
            display-ssh = "";
            display-drun = "";
            display-calc = "";
            display-combi = "";
            display-emoji = "";

            terminal = "kitty";
            sort = false;
            combi-display-format = "{mode} {text}";
            kb-mode-next = "Shift+Right,Control+Tab";
          };
          theme = let
            inherit (config.lib.formats.rasi) mkLiteral;
          in {
            "*" = {
              separatorcolor = mkLiteral "rgba(0,0,0,0%)";
              trprt = mkLiteral "#00000000";
              trprtbg = mkLiteral "rgba(50,50,50,80%)";
              xbg = mkLiteral "#1D1F28";
              xfg = mkLiteral "#FDFDFD";
              x0 = mkLiteral "#282A36";
              x1 = mkLiteral "#F37F97";
              x2 = mkLiteral "#5ADECD";
              x3 = mkLiteral "#F2A272";
              x4 = mkLiteral "#8897F4";
              x5 = mkLiteral "#C574DD";
              x6 = mkLiteral "#79E6F3";
              x7 = mkLiteral "#FDFDFD";
              x8 = mkLiteral "#414458";
              x9 = mkLiteral "#FF4971";
              x10 = mkLiteral "#18E3C8";
              x11 = mkLiteral "#FF8037";
              x12 = mkLiteral "#556FFF";
              x13 = mkLiteral "#B043D1";
              x14 = mkLiteral "#3FDCEE";
              x15 = mkLiteral "#FDFDFD";
            };
            "window" = {
              background-color = mkLiteral "#aabbcc50";
              border = mkLiteral "0";
              border-color = mkLiteral "@trprt";
              border-radius = mkLiteral "12px";
              padding = mkLiteral "0";
              width = mkLiteral "50%";
              height = mkLiteral "55%";
              children = map mkLiteral ["horibox"];
            };
            "mainbox" = {
              border = mkLiteral "0";
              padding = mkLiteral "0";
            };
            "horibox" = {
              orientation = mkLiteral "horizontal";
              children = map mkLiteral ["listview" "mode-switcher" "inputbar"];
            };
            "inputbar" = {
              width = mkLiteral "25%";
              height = mkLiteral "25%";
              margin = mkLiteral "520px 10px 10px 10px";
              padding = mkLiteral "20px 10px";
              background-color = mkLiteral "@trprtbg";
              border-radius = mkLiteral "12px";
              children = map mkLiteral ["prompt" "entry"];
            };
            "mode-switcher" = {
              orientation = mkLiteral "vertical";
              margin = mkLiteral "20px 10px";
            };
            "button" = {
              margin = mkLiteral "5px";
              padding = mkLiteral "5px 7px";
              background-color = mkLiteral "@xbg";
              text-color = mkLiteral "@x7";
              border = mkLiteral "2px";
              border-radius = mkLiteral "20px";
              border-color = mkLiteral "@x7";
            };
            "button selected" = {
              background-color = mkLiteral "@xbg";
              text-color = mkLiteral "@x7";
              border = mkLiteral "3px";
              border-radius = mkLiteral "20px";
              border-color = mkLiteral "@x9";
            };
            "textbox" = {
              text-color = mkLiteral "@xfg";
            };
            "listview" = {
              background-color = mkLiteral "@trprtbg";
              scrollbar = mkLiteral "false";
              margin = mkLiteral "-11px 0px"; # hide the dashed line"
            };

            "entry" = {
              text-color = mkLiteral "@x7";
              margin = mkLiteral "0px 15px";
              placeholder = mkLiteral "\"There is no place like ~/\"";
            };

            "element" = {
              spacing = mkLiteral "0px";
              margin = mkLiteral "10px";
              border-radius = mkLiteral "24px";
              orientation = mkLiteral "horizontal";
              children = map mkLiteral ["element-text"];
            };
            "element selected.normal" = {
              background-color = mkLiteral "@x9";
              text-color = mkLiteral "@xbg";
            };
            "element normal.normal" = {
              background-color = mkLiteral "rgba (0,0,0,0%)";
              text-color = mkLiteral "@xfg";
            };

            "element-text" = {
              vertical-align = mkLiteral "0.5";
              horizontal-align = mkLiteral "1.0";
              padding = mkLiteral "12px 25px";
            };

            "element normal.active" = {
              background-color = mkLiteral "rgba (0,0,0,0%)";
              text-color = mkLiteral "@x5";
            };
            "element alternate.normal" = {
              background-color = mkLiteral "rgba (0,0,0,0%)";
              text-color = mkLiteral "@xfg";
            };

            "prompt" = {
              spacing = mkLiteral "0";
              border = mkLiteral "0";
              text-color = mkLiteral "@xfg";
            };

            "textbox-prompt-colon" = {
              expand = mkLiteral "false";
              str = mkLiteral "\" ss \"";
              margin = mkLiteral "0px 0.3000em 0.0000em 0.0000em ";
              text-color = mkLiteral "inherit";
            };
          };
        };
      })
    ];
  };
}
