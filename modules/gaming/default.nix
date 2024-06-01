{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    cyanea.gaming.enable = lib.mkEnableOption "Enable gaming";
  };

  config = lib.mkIf (config.cyanea.graphical.gui.enable && config.cyanea.gaming.enable) {
    services.xserver.videoDrivers = ["amdgpu"];

    programs.steam.enable = true;
    programs.steam.gamescopeSession.enable = true;
    programs.gamemode.enable = true;

    environment.systemPackages = [pkgs.mangohud];
  };
}
