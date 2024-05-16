{ lib, pkgs, ... }:
{
    imports = [
        ./laptop/laptop.nix
        ./virtualization/virtualization.nix
        ./acpid/acpid.nix
        ./graphics/picom.nix
        ./autorandr/autorandr.nix
    ];

    laptop.enable = lib.mkDefault false;
    virtualization.enable = lib.mkDefault true;
    acpid.enable = lib.mkDefault true;
}
