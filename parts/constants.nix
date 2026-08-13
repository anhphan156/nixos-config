{
  flake.nixosModules.constants = { lib, ... }: {
    options.constants =
      let
        mkConstantStr =
          x:
          lib.mkOption {
            type = lib.types.str;
            default = x;
            readOnly = true;
            description = "username";
          };
      in
      {
        username = mkConstantStr "backspace";
        gitname = mkConstantStr "embers";
        gitemail = mkConstantStr "anh.phan156@protonmail.com";
      };

    options.desktop = {
      defaultSession = lib.mkOption {
        type = lib.types.str;
        default = "niri";
        description = "Default Sesssion for Display Manager";
      };
      greeterOutput = lib.mkOption {
        type = lib.types.str;
        description = "Default monitor for greeter";
      };
    };
  };
}
