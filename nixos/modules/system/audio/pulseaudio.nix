{ config, lib, ... }:
{
    options = {
        pulseaudio.enable = lib.mkEnableOption "Enable pulseaudio";
    };
    config = lib.mkIf config.pulseaudio.enable {
        nixpkgs.config.pulseaudio = true;
        hardware.pulseaudio.enable = true;
    };
}
