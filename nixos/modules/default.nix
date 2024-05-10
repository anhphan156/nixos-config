{ lib, pkgs, ... }:
{
    imports = [
        ./laptop/laptop.nix
        ./virtualization/virtualization.nix
        ./acpid/acpid.nix
    ];

    laptop.enable = lib.mkDefault true;
    virtualization.enable = lib.mkDefault true;
    acpid.enable = lib.mkDefault true;
}
