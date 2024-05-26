{
  user,
  rootPath,
  pkgs,
  config,
  lib,
  ...
}: {
    options = {
        nvim.enable = lib.mkEnableOption "Enable Neovim";
    };
    
    config = lib.mkIf config.nvim.enable {
        home-manager.users."${user.name}".home = {
            file = {
            ".config/nvim/".source = ../../../../../config/nvim;
            };
            packages = with pkgs; [
            neovim
            ];
        };
    };
}
