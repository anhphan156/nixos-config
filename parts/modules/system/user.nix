{
  flake.nixosModules.user = {config, ...}: {
    users.users."${config.constants.username}" = {
      isNormalUser = true;
      extraGroups = ["wheel"];
    };
  };
}
