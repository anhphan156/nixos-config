{
  pkgs,
  lib,
  config,
  ...
}: {
  options.cyanea.dev.rust.enable = lib.mkEnableOption "Enable rust dev tools";
  config = lib.mkIf config.cyanea.dev.rust.enable {
    environment.systemPackages = with pkgs; [
      rustc
      cargo
			rustup
    ];
  };
}
