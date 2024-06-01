{
  config,
  lib,
  ...
}: {
  options = {
    cyanea.system.pulseaudio.enable = lib.mkEnableOption "Enable pulseaudio";
  };
  config = lib.mkIf config.cyanea.system.pulseaudio.enable {
    nixpkgs.config.pulseaudio = true;
    hardware.pulseaudio.enable = true;
  };
}
