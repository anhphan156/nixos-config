{
  pkgs,
  lib,
  config,
  user,
  ...
}: {
  options.cyanea.dev.rust.enable = lib.mkEnableOption "Enable rust dev tools";
  config = lib.mkIf config.cyanea.dev.rust.enable {
    environment.systemPackages = with pkgs; [
      rustup
    ];
    home-manager.users."${user.name}" = {
      home.sessionPath = [
        "/home/${user.name}/.cargo/bin"
      ];
    };
  };
}
