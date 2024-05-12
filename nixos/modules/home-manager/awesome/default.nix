{ config, lib, ... }:
let
    awesome_path = "${config.home.homeDirectory}/dotfiles/config/awesome";
in
{
    home.file."${awesome_path}/themes/default/colors.lua".text = ''
            local colors = {}
            return colors
    '';
    xdg.configFile = {
        "awesome/".source = config.lib.file.mkOutOfStoreSymlink awesome_path;
    };
}
