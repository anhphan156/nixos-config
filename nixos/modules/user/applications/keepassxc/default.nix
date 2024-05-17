{ config, lib, user, pkgs, ... }:
{
    options = {
        keepassxc.enable = lib.mkEnableOption "Enable keepassxc";
    };

    config = lib.mkIf (config.gui.enable && config.keepassxc.enable) {
        home-manager.users."${user.name}".home.packages = [
            pkgs.keepassxc
        ];
    };
}
