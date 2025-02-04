{
  config,
  lib,
  ...
}: {
  options.cyanea.services.bluetooth.enable = lib.mkEnableOption "Enable Bluetooth";
  config = lib.mkIf config.cyanea.services.bluetooth.enable {
    hardware.bluetooth.enable = true; # enables support for Bluetooth
    hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
    services.blueman.enable = true;

    home-manager.users."${lib.user.name}" = {
      services.blueman-applet.enable = true;
    };
  };
}
