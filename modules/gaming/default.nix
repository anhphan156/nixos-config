{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    cyanea.gaming = {
      enable = lib.mkEnableOption "Enable gaming";
      nvidia.enable = lib.mkEnableOption "Enable gaming";
    };
  };

  config = lib.mkIf (config.cyanea.graphical.gui.enable && config.cyanea.gaming.enable) {
    services.xserver.videoDrivers = ["amdgpu" "nvidia"];

    hardware.nvidia = lib.mkIf config.cyanea.gaming.nvidia.enable {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;

      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:2:0:0";
      };
    };

    programs.steam.enable = true;
    programs.steam.gamescopeSession.enable = true;
    programs.gamemode.enable = true;

    environment.systemPackages = [pkgs.mangohud];
  };
}
