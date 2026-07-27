{
  flake.nixosModules.constants = {lib, ...}: {
    options.constants = let
      mkConstantStr = x:
        lib.mkOption {
          type = lib.types.str;
          default = x;
          readOnly = true;
          description = "username";
        };
    in {
      username = mkConstantStr "backspace";
      gitname = mkConstantStr "anhphan156";
      gitemail = mkConstantStr "anh.phan156@protonmail.com";
    };
  };
}
