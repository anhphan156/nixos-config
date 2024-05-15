{ config, lib, ... }:
let
    awesome_path = "${config.home.homeDirectory}/dotfiles/config/awesome";
in
{
    options = {
        awesome_config.enable = lib.mkEnableOption "enable awesome_config";
    };

    config = lib.mkIf config.awesome_config.enable {
        home.file."${awesome_path}/themes/default/colors.lua".text = ''
                local colors = {}
                return colors
        '';
        xdg.configFile = {
            "awesome/".source = config.lib.file.mkOutOfStoreSymlink awesome_path;
        };
    };
}
