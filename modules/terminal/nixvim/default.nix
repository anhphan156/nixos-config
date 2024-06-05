{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./keymaps.nix
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

      highlight = {
        NeoTreeNormal.bg = "NONE";
        NeoTreeNormal.ctermbg = "NONE";
        NeoTreeNormalNC.bg = "NONE";
        NeoTreeNormalNC.ctermbg = "NONE";
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

      plugins = {
        treesitter.enable = true;
        fugitive.enable = true;
        telescope.enable = true;
        gitsigns.enable = true;

        presence-nvim = {
          enable = true;
          autoUpdate = true;
        };

        startup = {
          enable = true;
          theme = "evil";
        };

        lsp = {
          enable = true;
          servers = {
            clangd.enable = true;
            nixd.enable = true;
            lua-ls.enable = true;
            rust-analyzer.enable = true;
            rust-analyzer.installRustc = true;
            rust-analyzer.installCargo = true;
          };
        };
        lsp-format = {
          enable = true;
          lspServersToEnable = "all";
        };
        cmp = {
          enable = true;
          autoEnableSources = true;
          settings = {
            mapping = {
              __raw = ''
                cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                  })
              '';
            };
            sources = [
              {
                name = "nvim_lsp";
              }
              {
                name = "path";
              }
              {
                name = "buffer";
              }
            ];
          };
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
          buffers.followCurrentFile.enabled = true;
        };

        lualine = {
          enable = true;
          theme = "auto";
        };

        mini = {
          enable = true;
          modules = {
            pairs = {
              mappings = {
                "\"" = {
                  action = "closeopen";
                  pair = "\"\"";
                  neigh_pattern = "[^\\`].";
                  register = {cr = true;};
                };
              };
            };
          };
        };

        indent-blankline = {
          enable = true;
          settings = {
            scope = {
              show_end = false;
              show_exact_scope = true;
              show_start = true;
            };
            debounce = 200;
          };
        };

        notify.enable = true;
        noice = {
          enable = true;
        };
      };

      extraPlugins = with pkgs.vimPlugins; [
        nui-nvim
      ];
    };
  };
}
