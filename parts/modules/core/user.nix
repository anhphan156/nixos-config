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
}
