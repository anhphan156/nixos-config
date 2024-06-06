{
  config,
  lib,
  ...
}: {
  imports = [
    ./keymaps.nix
    ./plugins.nix
  ];

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

      opts = {
        number = true;
        relativenumber = true;
        shiftwidth = 2;
        tabstop = 2;
        smartindent = true;
      };

      clipboard = {
        register = "unnamedplus";
        providers.wl-copy.enable = lib.mkIf config.cyanea.graphical.hyprland.enable true;
      };

      highlightOverride = {
        NvimTreeNormal.bg = "NONE";
        NvimTreeNormalNC.bg = "NONE";
        NvimTreeWinSeparator.bg = "NONE";
        NvimTreeWinSeparator.fg = "#000000";
      };

      autoCmd = [
        {
          event = ["BufRead"];
          pattern = ["*.nix"];
          command = "%!alejandra -qq";
        }
      ];

      colorschemes.tokyonight = {
        enable = true;
        settings.transparent = true;
      };
    };
  };
}
