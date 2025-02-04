{
  lib,
  config,
  ...
}: {
  options.cyanea.system.hostname = lib.mkOption {
    description = "networking host name";
    type = lib.types.str;
    default = "Cyanea";
  };

  config = {
    networking = {
      networkmanager.enable = true;
      hostName = config.cyanea.system.hostname;
      useDHCP = lib.mkDefault true;
      # interfaces.wlo1.useDHCP = lib.mkDefault true;
    };
    users.users."${lib.user.name}" = {
      extraGroups = lib.mkAfter ["networkmanager"];
    };
  };
}
