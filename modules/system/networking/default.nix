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
    };
    users.users."${lib.user.name}" = {
      extraGroups = lib.mkAfter ["networkmanager"];
    };
  };
}
