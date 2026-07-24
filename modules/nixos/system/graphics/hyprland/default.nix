{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.cyanea.graphical;
in {
  options = {
    cyanea.graphical.hyprland = {
      enable = lib.mkEnableOption "Enable hyprland";
      extraConfig = lib.mkOption {
        description = "extra config for hyprland";
        type = lib.types.str;
        default = "";
      };
    };
  };

  config = lib.mkIf (cfg.hyprland.enable && cfg.gui.enable) {
    cyanea = {
      desktopApp.rofi = lib.enabled;
      graphical = {
        eww = lib.enabled;
        mako = lib.enabled;
      };
    };

    programs.hyprland = {
      enable = true;
    };

    home-manager.users."${lib.user.name}" = {
      xdg.configFile = let
        hyprland_lua = let
          base = builtins.readFile "${pkgs.myDotfiles}/share/hypr/hyprland.lua";
          set_wallpaper = pkgs.writeShellApplication {
            name = "random-awww";
            runtimeInputs = [pkgs.awww];
            text = ''
              wallpapers=${pkgs.wallpapers}/single
              random=$(ls $wallpapers | shuf | head -1)
              random=$wallpapers/$random
              awww img --transition-type center "$random"
            '';
            excludeShellChecks = ["SC2012"];
          };
        in ''
          ${base}
          ${cfg.hyprland.extraConfig}
          hl.on("hyprland.start", function()
            hl.exec_cmd("awww-daemon&")
            hl.exec_cmd("${lib.getExe set_wallpaper}")
          end)
          hl.bind("Print", hl.dsp.exec_cmd("${lib.getExe pkgs.screenshot_script}"))
        '';
      in {
        "hypr/hyprland.lua".text = hyprland_lua;
        "pypr/config.toml".source = "${pkgs.myDotfiles}/share/hypr/pyprland.toml";
      };
    };
  };
}
