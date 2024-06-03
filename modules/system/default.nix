{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./laptop/laptop.nix
    ./laptop/touchpad.nix
    ./acpid/acpid.nix
    ./graphics/picom
    ./autorandr/autorandr.nix
    ./graphics/awesome
    ./graphics/xserver
    ./graphics/sddm
    ./graphics/hyprland
    ./graphics/eww/default.nix
    ./audio/pipewire.nix
    ./audio/pulseaudio.nix
    ./networking
    ./users
    ./nix_settings
    ./locale
    ./openssh
		./light
  ];
}
