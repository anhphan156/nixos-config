{
  config,
  lib,
  pkgs,
  ...
}: {
  options.pass.enable = lib.mkEnableOption "Enable password-store";

  config = lib.mkIf config.pass.enable {
    home-manager.users."${lib.user.name}" = {
      programs.password-store = {
        enable = true;
      };
    };
  };
}
