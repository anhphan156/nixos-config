{
  flake.modules.nixos.core = { config, lib, ... }: {
    options.username = lib.mkOption {
      type = lib.types.str;
      default = "backspace";
      readOnly = true;
      description = "username";
    };

    config = {
      users.users."${config.username}" = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
      };
    };
  };

  flake.modules.nixos.ephemeralUser = { config, ... }: {
    users.mutableUsers = false;
    users.users."${config.username}" = {
      hashedPasswordFile = "/persistence/passwords/backspace.hash";
    };
  };
}
