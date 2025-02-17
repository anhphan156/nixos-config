{
  config,
  lib,
  ...
}: {
  options = {
    cyanea.graphical.hyprland.pyprland.enable = lib.mkEnableOption "Enable pyprland";
  };

  config = lib.mkIf (with config.cyanea.graphical; (gui.enable && hyprland.enable && hyprland.pyprland.enable)) {
    home-manager.users."${lib.user.name}" = {
      xdg.configFile = {
        "hypr/pyprland.toml".text = ''
          [pyprland]
          plugins = ["scratchpads"]

          [scratchpads.kitty]
          animation = "fromTop"
          command = "kitty --class kitty-dropterm"
          class = "kitty-dropterm"
          size = "75% 60%"
          max_size = "1920px 100%"
          margin = 50

          [scratchpads.nemo]
          animation = "fromTop"
          command = "nemo"
          class = "nemo"
          size = "75% 60%"
          max_size = "1920px 100%"
          margin = 50

          [scratchpads.obsidian]
          animation = "fromTop"
          command = "obsidian"
          class = "obsidian"
          size = "75% 60%"
          max_size = "1920px 100%"
          margin = 50
          lazy = true

          [scratchpads.pavucontrol]
          animation = "fromRight"
          command = "pavucontrol"
          class = "pavucontrol"
          size = "75% 60%"
          max_size = "1920px 100%"
          margin = 50
          unfocus = "hide"
          hysteresis = 0.1
          lazy = true
        '';
      };
    };
  };
}
