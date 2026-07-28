{
  flake.nixosModules.light = { config, lib, ... }: {
    services.udev.extraRules = ''
      SUBSYSTEM=="backlight", ACTION=="add", KERNEL=="intel_backlight", ATTR{brightness}="2400"
    '';

    users.users."${config.constants.username}" = {
      extraGroups = lib.mkAfter [ "video" ];
    };
  };
}
