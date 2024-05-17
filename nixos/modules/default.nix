{ lib, ... }:
{
    imports = [
        ./user   
        ./system
    ];

    options = {
        gui.enable = lib.mkEnableOption "Enable GUI";
    };
}
