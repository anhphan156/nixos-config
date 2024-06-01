{
  config,
  lib,
  ...
}: {
  options = {
    cyanea.system.pipewire.enable = lib.mkEnableOption "Enable Pipewire";
  };

  config = lib.mkIf config.cyanea.system.pipewire.enable {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
