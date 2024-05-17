{ lib, ... }:
{
    imports = [
        ./user   
        ./system
    ];

    options = {
        gui.enable = lib.mkEnableOption "Enable GUI";
        isBacklight.enable = lib.mkEnableOption "Enable services only for backlight";
        isOmega.enable = lib.mkEnableOption "Enable services only for omega";
    };
}
