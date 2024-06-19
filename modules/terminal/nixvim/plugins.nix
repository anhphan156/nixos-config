{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.nixvim.enable {
    programs.nixvim = {
      plugins = {
        treesitter.enable = true;
        fugitive.enable = true;
        telescope.enable = true;
        gitsigns.enable = true;
        notify.enable = true;
        noice.enable = true;
        floaterm.enable = true;

        bufferline = {
          enable = true;
          mode = "tabs";
        };

        presence-nvim = {
          enable = true;
          autoUpdate = true;
        };

        startup = {
          enable = true;
          theme = "evil";
        };

        lspsaga = {
          enable = true;
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
					keymaps.lspBuf = {
						K = "hover";
						gD = "references";
						gd = "definition";
						gi = "implementation";
						gy = "type_definition";
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
            window = {
              completion = {
                border = "rounded";
                winhighlight = "FloatBorder:NormalFloat";
              };
              documentation = {
                border = "rounded";
                winhighlight = "FloatBorder:NormalFloat";
              };
            };
            mapping = {
              __raw = ''
                cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'}),
                    ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'}),
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
            formatting = {
              expandable_indicator = true;
              fields = ["abbr" "kind" "menu"];
            };
          }; # settings
        }; # cmp

        lspkind = {
          enable = true;
          mode = "symbol_text";
          preset = "codicons";
          cmp = {
            enable = true;
            after = ''
              function(_, item)
              	item.menu = ""
              	return item
              end
            '';
          };
        };

        nvim-tree = {
          enable = true;
          autoClose = true;
          autoReloadOnWrite = true;
          git.enable = true;
          updateFocusedFile = lib.enabled;
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
            }; # pairs
            animate = {};
          }; # modules
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
      };

      extraPlugins = with pkgs.vimPlugins; [
        nui-nvim
        # {
        # 	plugin = hex-nvim;
        # 	config = ''lua require 'hex'.setup()'';
        # }
      ];
    };
  };
}
