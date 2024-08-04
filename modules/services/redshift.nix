{
  config,
  lib,
  user,
  ...
}: {
  options.cyanea.services.redshift.enable = lib.mkEnableOption "Enable Redshift";
  config = lib.mkIf config.cyanea.services.redshift.enable {
    location = {
      provider = "manual";
    };
    services.redshift = {
      enable = true;
      temperature = {
        day = 9000;
        night = 1000;
      };
    };
  };
}
