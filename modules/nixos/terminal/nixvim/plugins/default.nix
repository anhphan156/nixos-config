{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  config = mkIf config.nixvim.enable {
    programs.nixvim = {
      plugins = {
        fugitive = enabled;
        telescope = enabled;
        gitsigns = enabled;
        noice = enabled;
        floaterm = enabled;
        headlines = enabled;
        otter = enabled;

        treesitter = {
          enable = true;
          settings = {
            highlight.enable = true;
          };
        };

        notify = {
          enable = true;
          topDown = false;
          timeout = 1000;
        };

        bufferline = {
          enable = true;
          settings.options.mode = "tabs";
        };

        presence-nvim = {
          enable = true;
          autoUpdate = true;
        };

        startup = {
          enable = true;
          theme = "evil";
        };

        luasnip = {
          enable = true;
          settings = {
            enable_autosnippets = true;
            store_selection_keys = "<Tab>";
          };
          fromLua = [
            {paths = "${pkgs.myDotfiles}/share/nvim/snippets";}
          ];
        }; #luasnip

        nvim-tree = {
          enable = true;
          autoClose = true;
          autoReloadOnWrite = true;
          git.enable = true;
          updateFocusedFile = lib.enabled;
        };

        lualine = {
          enable = true;
          settings.options.theme = "auto";
        };

        mini = {
          enable = true;
          mockDevIcons = true;
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
            icons = {};
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

        chatgpt = {
          enable = false;
          settings = {
            show_line_numbers = true;
            api_key_cmd = "echo -n <key-goes-here>";
            extra_curl_params = [
              "-H"
              "Origin: https://example.com"
            ];
          };
        };
      }; # plugins end

      extraPlugins = mkBefore (with pkgs.vimPlugins;
        with pkgs; [
          {
            plugin = nui-nvim;
          }
          # {
          # 	plugin = hex-nvim;
          # 	config = ''lua require 'hex'.setup()'';
          # }
          # {
          #   plugin = vimUtils.buildVimPlugin {
          #     name = "leetcode";
          #     src = fetchFromGitHub {
          #       owner = "kawre";
          #       repo = "leetcode.nvim";
          #       rev = "02fb2c855658ad6b60e43671f6b040c812181a1d";
          #       hash = "sha256-YoFRd9Uf+Yv4YM6/l7MVLMjfRqhroSS3RCmZvNowIAo=";
          #     };
          #   };
          #   config = ''lua require 'leetcode'.setup() '';
          # }
        ]);
    };
  };
}
