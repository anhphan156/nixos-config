{ user, rootPath, pkgs, ... }:
{
    home-manager.users."${user.name}".home = {
        file = {
            ".config/nvim/".source = ../../../../../config/nvim;
        };
        packages = with pkgs; [
            neovim
        ];
    };
}
