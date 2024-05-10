{ lib, ... }:
{
    imports = [
        ./laptop/laptop.nix
        ./virtualization/virtualization.nix
        #(import ../../modules/acpid/acpid.nix { inherit pkgs awesome; })
    ];

    laptop.enable = lib.mkDefault true;
    virtualization.enable = lib.mkDefault true;
    acpid.enable = lib.mkDefault true;
}
