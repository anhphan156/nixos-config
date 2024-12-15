{
  pkgs,
  lib,
  config,
  ...
}: {
  options.cyanea.dev.rust.enable = lib.mkEnableOption "Enable rust dev tools";
  config = lib.mkIf config.cyanea.dev.rust.enable {
    environment.systemPackages = with pkgs; [
      rustup
    ];
    home-manager.users."${lib.user.name}" = {
      home.sessionPath = [
        "/home/${lib.user.name}/.cargo/bin"
      ];
    };
  };
}
