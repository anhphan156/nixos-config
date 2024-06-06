{
  user,
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
    networking.hostName = config.cyanea.system.hostname;
    networking.networkmanager.enable = true;
    users.users."${user.name}" = {
      extraGroups = lib.mkAfter ["networkmanager"];
    };
  };
}
