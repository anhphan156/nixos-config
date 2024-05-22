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

        lualine = {
          enable = true;
          theme = "auto";
        };

        mini = {
          enable = true;
          modules = {
            pairs = {};
          };
        };

        indent-blankline = {
          enable = true;
	  settings = {
		scope = {
		show_end = false;
		show_exact_scope = true;
		show_start = false;
		};
	  };
        };

        dressing = {
          enable = true;
          settings = {
            input = {
              enabled = true;
              border = "rounded";
              insert_only = true;
              mappings = {
                i = {
                  "<C-c>" = "Close";
                  "<CR>" = "Confirm";
                  "<Down>" = "HistoryNext";
                  "<Up>" = "HistoryPrev";
                };
              };
            };
          };
        };

      	noice = {
	enable = true;
	};
      };
    };
  };
}
