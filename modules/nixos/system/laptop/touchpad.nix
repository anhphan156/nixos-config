{
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.cyanea.system.laptop.enable {
    services.libinput.touchpad.naturalScrolling = true;
  };
}
