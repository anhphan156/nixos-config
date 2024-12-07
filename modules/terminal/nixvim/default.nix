{
  config,
  lib,
  ...
}: {
  options = {
    nixvim.enable = lib.mkOption {
      default = true;
      type = lib.types.bool;
      description = "Enable Nixvim";
    };
  };

  config = lib.mkIf config.nixvim.enable {
    programs.nixvim = {
      enable = true;

      clipboard = {
        register = "unnamedplus";
        providers.wl-copy.enable = config.cyanea.graphical.hyprland.enable;
      };

      highlightOverride = {
        NvimTreeNormal.bg = "NONE";
        NvimTreeNormalNC.bg = "NONE";
        NvimTreeWinSeparator.bg = "NONE";
        NvimTreeWinSeparator.fg = "#000000";
        NormalFloat.bg = "NONE"; #cmp menu no bg
      };

      # autoCmd = [
      #   {
      #     event = ["BufRead"];
      #     pattern = ["*.nix"];
      #     command = "%!alejandra -qq";
      #   }
      # ];

      colorschemes.tokyonight = {
        enable = true;
        settings.transparent = true;
      };
    };
  };
}
