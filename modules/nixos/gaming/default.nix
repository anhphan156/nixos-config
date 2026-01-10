{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    cyanea.gaming = {
      enable = lib.mkEnableOption "Enable gaming";
      gamescopeMonitor = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
      };
      nvidia.enable = lib.mkEnableOption "Enable gaming";
      driver = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
      };
    };
  };

  config = lib.mkIf (config.cyanea.graphical.gui.enable && config.cyanea.gaming.enable) {
    services.xserver.videoDrivers = config.cyanea.gaming.driver;

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

    programs = {
      steam = {
        enable = true;
        gamescopeSession = {
          enable = true;
          args = config.cyanea.gaming.gamescopeMonitor;
        };
      };
      gamemode.enable = true;
    };

    environment.systemPackages = with pkgs; [
      mangohud
      protonup-ng
    ];
  };
}
