{
  config,
  lib,
  ...
}: {
  options.cyanea.system.light_control.impermanence.enable = lib.mkEnableOption "Set rule for brightness";

  config = lib.mkIf config.cyanea.system.light_control.impermanence.enable {
    services.udev.extraRules = ''
      SUBSYSTEM=="backlight", ACTION=="add", KERNEL=="intel_backlight", ATTR{brightness}="2400"
    '';
  };
}
