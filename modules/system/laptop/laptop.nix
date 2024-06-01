{
  lib,
  config,
  ...
}: {
  options = {
    cyanea.system.laptop.enable = lib.mkEnableOption "enable laptop";
  };

  config = lib.mkIf config.cyanea.system.laptop.enable {
    services.auto-cpufreq.enable = true;
    services.auto-cpufreq.settings = {
      battery = {
        governor = "powersave";
        turbo = "never";
      };
      charger = {
        governor = "performance";
        turbo = "auto";
      };
    };
  };
}
