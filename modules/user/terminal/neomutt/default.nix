{
  config,
  lib,
  user,
  pkgs,
  ...
}: {
  options.neomutt.enable = lib.mkEnableOption "Enable neomutt";

  config = lib.mkIf config.neomutt.enable {
    home-manager.users."${user.name}" = {
      # home.packages = with pkgs; [
      #   protonmail-bridge
      # ];

      programs.offlineimap = {
        enable = false;
      };
    };
  };
}
