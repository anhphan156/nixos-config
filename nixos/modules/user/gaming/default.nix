{ config, lib, pkgs, ... }:
{
    options = {
        gaming.enable = lib.mkEnableOption "Enable gaming";
    };

    config = lib.mkIf (config.gui.enable && config.gaming.enable) {
        services.xserver.videoDrivers = ["amdgpu"];

        programs.steam.enable = true;
        programs.steam.gamescopeSession.enable = true;
        programs.gamemode.enable = true;

        environment.systemPackages = [ pkgs.mangohud ];
    };
}
