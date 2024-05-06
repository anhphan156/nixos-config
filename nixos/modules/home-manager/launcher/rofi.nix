{ config, pkgs } :
{
    programs.rofi = {
        enable = true;
        plugins = with pkgs; [
            rofi-calc
            rofi-emoji
        ];
        extraConfig = {
            modes= "window,drun,run,combi";
            combi-modes= "window,drun,run";
            font= "AnkaCoder 15";

            display-window= "";
            display-run= "";
            display-ssh= "";
            display-drun= "";
            display-calc= "";
            display-combi= "";
            display-emoji= "";

            separator-style= "solid";
            color-normal= "#1D1F28, #FDFDFD, #1D1F28, #FDFDFD, #1D1F28";
            color-urgent= "#1D1F28, #F37F97, #1D1F28, #F37F97, #FDFDFD";
            color-active= "#1D1F28, #FDFDFD, #1D1F28, #FDFDFD, #1D1F28";
            color-window= "#1D1F28, #F37F97, #FDFDFD";

            window-format= "[{w}] ·· {c} ··   {t}";

            location= 0;
            terminal = "kitty";
            sort = false;
            sidebar-mode = true;
            combi-display-format = "{mode} {text}";
            kb-mode-next = "Shift+Right,Control+Tab";
        };
        theme = let inherit (config.lib.formats.rasi) mkLiteral; in {
            "*" = {
                selected-normal-foreground = mkLiteral "rgba ( 52, 60, 72, 100 % )";
                foreground = mkLiteral                 "rgba ( 224, 224, 224, 100 % )";
                normal-foreground = mkLiteral          "@foreground";
                alternate-normal-background = mkLiteral "rgba ( 52, 60, 72, 100 % )";
                red = mkLiteral                        "rgba ( 220, 50, 47, 100 % )";
                selected-urgent-foreground = mkLiteral "rgba ( 224, 224, 224, 100 % )";
                blue = mkLiteral                       "rgba ( 38, 139, 210, 100 % )";
                urgent-foreground = mkLiteral          "rgba ( 240, 98, 146, 100 % )";
                alternate-urgent-background = mkLiteral "rgba ( 52, 60, 72, 100 % )";
                active-foreground = mkLiteral          "rgba ( 224, 224, 224, 100 % )";
                lightbg = mkLiteral                    "rgba ( 238, 232, 213, 100 % )";
                selected-active-foreground = mkLiteral "rgba ( 52, 60, 72, 100 % )";
                alternate-active-background = mkLiteral "rgba ( 52, 60, 72, 100 % )";
                background = mkLiteral                 "rgba ( 52, 60, 72, 100 % )";
                alternate-normal-foreground = mkLiteral "@foreground";
                normal-background = mkLiteral          "rgba ( 52, 60, 72, 100 % )";
                lightfg = mkLiteral                    "rgba ( 88, 104, 117, 100 % )";
                selected-normal-background = mkLiteral "rgba ( 224, 224, 224, 100 % )";
                border-color = mkLiteral               "rgba ( 240, 98, 146, 100 % )";
                separatorcolor = mkLiteral             "rgba ( 224, 224, 224, 100 % )";
                urgent-background = mkLiteral          "rgba ( 52, 60, 72, 100 % )";
                selected-urgent-background = mkLiteral "rgba ( 240, 98, 146, 100 % )";
                alternate-urgent-foreground = mkLiteral "@urgent-foreground";
                background-color = mkLiteral           "rgba ( 0, 0, 0, 0 % )";
                alternate-active-foreground = mkLiteral "@active-foreground";
                active-background = mkLiteral          "rgba ( 52, 60, 72, 100 % )";
                selected-active-background = mkLiteral "rgba ( 224, 224, 224, 100 % )";
                xbg = mkLiteral    "#1D1F28";
                xfg = mkLiteral    "#FDFDFD";
                x0 = mkLiteral     "#282A36";
                x1 = mkLiteral     "#F37F97";
                x2 = mkLiteral     "#5ADECD";
                x3 = mkLiteral     "#F2A272";
                x4 = mkLiteral     "#8897F4";
                x5 = mkLiteral     "#C574DD";
                x6 = mkLiteral     "#79E6F3";
                x7 = mkLiteral     "#FDFDFD";
                x8 = mkLiteral     "#414458";
                x9 = mkLiteral     "#FF4971";
                x10 = mkLiteral    "#18E3C8";
                x11 = mkLiteral    "#FF8037";
                x12 = mkLiteral    "#556FFF";
                x13 = mkLiteral    "#B043D1";
                x14 = mkLiteral    "#3FDCEE";
                x15 = mkLiteral    "#FDFDFD";
            };
            "window" = {
                background-image = mkLiteral "url(\"dotfiles/config/rofi/bg.jpg\")";
                border = mkLiteral "0";
                border-color = mkLiteral "@x14";
                border-radius = mkLiteral "12px";
                padding = mkLiteral "00";
                width = mkLiteral "50%";
                height = mkLiteral "55%";
                children = map mkLiteral [ "horibox" ];
            };
            "mainbox" = {
                border = mkLiteral "0";
                padding = mkLiteral "0";
            };
            "horibox" = {
                orientation = mkLiteral "horizontal";
                children = map mkLiteral [ "listview" "mode-switcher" "prompt" "entry" ];
            };
            "mode-switcher" = {
                orientation = mkLiteral "vertical";
                margin = mkLiteral "20px 10px";
            };
            "button" = {
                margin = mkLiteral "5px";
                padding = mkLiteral "5px";
                background-color = mkLiteral "@xbg";
                text-color = mkLiteral "@x7";
                border = mkLiteral "2px";
                border-radius = mkLiteral "20px";
                border-color = mkLiteral "@x7";
            };
            "button selected" = {
                background-color = mkLiteral "@xbg";
                text-color = mkLiteral       "@x7";
                border = mkLiteral       "3px";
                border-radius = mkLiteral "20px";
                border-color = mkLiteral     "@x9";
            };
            "textbox" = {
                text-color = mkLiteral "@xfg";
            };
            "listview" = {
                scrollbar = mkLiteral "false";
                margin = mkLiteral "-11px 0px"; # hide the dashed line"
            };

            "entry" = {
                spacing = mkLiteral    "0";
                text-color = mkLiteral "@xfg";
                margin = mkLiteral "520px 0px 0px 00px";
                placeholder = mkLiteral "\"There is no place like ~/\"";
            };

            "element" = {
                spacing = mkLiteral "0px";
                margin = mkLiteral "10px 0px 0px 0px";
                orientation = mkLiteral "horizontal";
                children = map mkLiteral [ "element-text" ];
            };
            "element selected.normal" = {
                background-color = mkLiteral "rgba (100,222,180,10%)";
                text-color = mkLiteral       "@x2";
            };
            "element normal.normal" = {
                background-color = mkLiteral "rgba (0,0,0,0%)";
                text-color = mkLiteral       "@xfg";
            };

            "element-text" = {
                vertical-align = mkLiteral  "0.5";
                horizontal-align = mkLiteral "1.0";
                padding = mkLiteral "13px 25px";
                text-color = mkLiteral       "@xfg";
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
                spacing = mkLiteral    "0";
                border = mkLiteral     "0";
                text-color = mkLiteral "@xfg";
                margin = mkLiteral "520px 15px 0px 20px";
            };

            "textbox-prompt-colon" = {
                expand = mkLiteral     "false";
                str = mkLiteral        "\" ss \"";
                margin = mkLiteral     "0px 0.3000em 0.0000em 0.0000em ";
                text-color = mkLiteral "inherit";
            };
        };
    };
}
