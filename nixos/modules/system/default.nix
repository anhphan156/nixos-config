{ lib, pkgs, ... }:
{
    imports = [
        ./laptop/laptop.nix
        ./laptop/touchpad.nix
        ./virtualization/virtualization.nix
        ./acpid/acpid.nix
        ./graphics/picom.nix
        ./autorandr/autorandr.nix
        ./graphics/awesome
        ./graphics/xserver
        ./graphics/sddm
        ./graphics/hyprland
        ./audio/pipewire.nix
        ./audio/pulseaudio.nix
    ];

    acpid.enable = lib.mkDefault true;
}
