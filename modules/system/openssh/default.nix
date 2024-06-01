{
  config,
  lib,
  ...
}: {
  options.cyanea.system.openssh.enable = lib.mkEnableOption "Enable ssh";
  config = lib.mkIf config.cyanea.system.openssh.enable {
    services.openssh.enable = true;
    services.openssh.settings.PermitRootLogin = "no";
    services.openssh.settings.PasswordAuthentication = true;
  };
}
