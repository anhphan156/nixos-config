{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.nixvim.enable {
    programs.nixvim = {
      extraPlugins =
        lib.mkAfter [
          {
            plugin = pkgs.vimUtils.buildVimPlugin {
              name = "vim-dadbod";
              src = pkgs.fetchFromGitHub {
                owner = "tpope";
                repo = "vim-dadbod";
                rev = "7888cb7164d69783d3dce4e0283decd26b82538b";
                # hash = "sha256-FCSEIWC/dwdPqZ+Iw7prDdGpTRaWgoG0FEEGFwLSswk=";
                hash = "sha256-8wnUSYctVn3JeCVz2fdi9qcKi8ZyA4To+xs4WaP6rog=";
              };
            };
          }
          {
            plugin = pkgs.vimUtils.buildVimPlugin {
              name = "vim-dadbod-ui";
              src = pkgs.fetchFromGitHub {
                owner = "kristijanhusak";
                repo = "vim-dadbod-ui";
                rev = "0f51d8de368c8c6220973e8acd156d17da746f4c";
                hash = "sha256-+WQkYVopdw6eddhSyMqAvgD8V3De505jI6ruUzkPZt0=";
              };
            };
          }
        ];
    };
  };
}
