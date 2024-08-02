{
  config,
  lib,
  ...
}: {

  config = lib.mkIf config.nixvim.enable {
    programs.nixvim = {
      enable = true;

      opts = {
        number = true;
        relativenumber = true;
        shiftwidth = 2;
        tabstop = 2;
        smartindent = true;
        scl = "yes";
        scrolloff = 5;
      };

      files = let
        c_opts.opts = {
          shiftwidth = 4;
          tabstop = 4;
        };
      in {
        "ftplugin/c.lua" = {
          inherit (c_opts) opts;
        };

        "ftplugin/cpp.lua" = {
          inherit (c_opts) opts;
        };

        "ftplugin/nix.lua" = {
          opts = {
            expandtab = true;
            shiftwidth = 2;
            tabstop = 2;
          };
        };
      };

    };
  };
}
