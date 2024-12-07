{
  config,
  lib,
  ...
}: let
  inherit (lib) enabled mkIf;
in {
  config = mkIf config.nixvim.enable {
    programs.nixvim = {
      plugins = {
        lspsaga = {
          enable = true;
        };

        lsp = {
          enable = true;
          servers = {
            clangd = enabled;
            nixd = {
              enable = true;
              cmd = ["nixd"];
              extraOptions = {
                settings.nixd.formatting.command = ["alejandra"];
              };
            };
            eslint = enabled;
            lua_ls = enabled;
            rust_analyzer = {
              enable = true;
              installRustc = true;
              installCargo = true;
            };
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
        }; # lspkind
      }; # plugins
    }; # program.nixvim
  }; # config
}
