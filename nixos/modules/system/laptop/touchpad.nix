{
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.laptop.enable {
    services.libinput.touchpad.naturalScrolling = true;
  };
}
