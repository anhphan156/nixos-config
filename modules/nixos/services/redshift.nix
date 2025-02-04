{
  config,
  lib,
  ...
}: {
  options.cyanea.services.redshift.enable = lib.mkEnableOption "Enable Redshift";
  config = lib.mkIf config.cyanea.services.redshift.enable {
    location = {
      provider = "manual";
      latitude = 43.0;
      longitude = -79.0;
    };
    services.redshift = {
      enable = true;
      temperature = {
        day = 6500;
        night = 3000;
      };
    };
  };
}
