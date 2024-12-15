{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    cyanea.desktopApp.obsidian.enable = lib.mkEnableOption "Enable obsidian";
  };

  config = lib.mkIf (config.cyanea.desktopApp.obsidian.enable && config.cyanea.graphical.gui.enable) {
    home-manager = lib.install [
      pkgs.obsidian
    ];

    programs.nixvim = lib.mkIf config.nixvim.enable {
      keymaps = lib.mkAfter [
        {
          action = "<cmd>ObsidianQuickSwitch<cr>";
          key = "<leader>oo";
          options.silent = true;
          mode = "n";
        }
      ];
      plugins = {
        obsidian = {
          enable = true;
          settings = {
            workspaces = [
              {
                name = "obsidian";
                path = "~/data/obsidian";
              }
            ];
          };
        };
      };
    };
  };
}
