{
  config,
  lib,
  ...
}: {
  options.cyanea.system.bootloader = {
    confLim = lib.mkOption {
      type = lib.types.int;
      default = 3;
      description = "Number of configuration in systemd bootloader";
    };
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "enable bootloader";
    };
  };

  config = lib.mkIf config.cyanea.system.bootloader.enable {
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.systemd-boot.configurationLimit = config.cyanea.system.bootloader.confLim;
  };
}
