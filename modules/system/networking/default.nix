{
  user,
  lib,
  config,
  ...
}: {
  options.system.hostname = lib.mkOption {
    description = "networking host name";
    type = lib.types.str;
    readOnly = true;
    default = "Cyanea";
  };

  config = {
    networking.hostName = config.system.hostname;
    networking.networkmanager.enable = true;
    users.users."${user.name}" = {
      extraGroups = lib.mkAfter ["networkmanager"];
    };
  };
}
