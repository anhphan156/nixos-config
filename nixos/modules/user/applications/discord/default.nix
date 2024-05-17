{ lib, config, user, pkgs, ... }:
{
    options = {
        discord.enable = lib.mkEnableOption "Enable Discord";
    };

    config = lib.mkIf (config.discord.enable && config.gui.enable) {
        home-manager.users."${user.name}".home.packages = with pkgs; [
            discord
        ];
    };
}
