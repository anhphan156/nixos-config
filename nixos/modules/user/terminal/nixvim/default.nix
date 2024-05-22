{
  config,
  lib,
  user,
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

      autoCmd = [
        {
          event = ["BufRead"];
          pattern = ["*.nix"];
          command = "%!alejandra -qq";
        }
      ];

      keymaps = [
        {
          action = "<esc>";
          key = "jk";
          options.silent = true;
          mode = "i";
        }
        {
          action = "<esc>:w<CR>";
          key = "<leader>w";
          options.silent = true;
          mode = "n";
        }
        {
          action = ":Neotree toggle<CR>";
          key = "<leader>t";
          options.silent = true;
          mode = "n";
        }
        {
          action = "<cmd>Telescope find_files<cr>";
          key = "<leader>ff";
          options.silent = true;
          mode = "n";
        }
        {
          action = "<cmd>Telescope live_grep<cr>";
          key = "<leader>fg";
          options.silent = true;
          mode = "n";
        }
      ];

      colorschemes.tokyonight = {
        enable = true;
        settings.transparent = true;
      };

      plugins = {
        treesitter.enable = true;
        fugitive.enable = true;
        telescope.enable = true;
        neocord.enable = true;

        autoclose = {
          enable = true;
          options.autoIndent = true;
        };
        bufferline = {
          enable = true;
        };

        transparent = {
          enable = true;
          settings.extra_groups = [
            "NeoTreeNormal"
            "NeoTreeNormalNC"
          ];
        };

        neo-tree = {
          enable = true;
          enableGitStatus = true;
          enableModifiedMarkers = true;
          enableRefreshOnWrite = true;
          closeIfLastWindow = true;
          popupBorderStyle = "NC";
        };

        airline = {
          enable = true;
          settings = {
            powerline_fonts = true;
            theme = "dark";
          };
        };
      };
    };
  };
}
