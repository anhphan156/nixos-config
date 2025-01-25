{
  lib,
  inputs,
  config,
  ...
}: let
  overlays = [
    inputs.nvim-config.overlays.default
    (import ./wrapDesktopItem.nix)
    (import ./awesome.nix)
    (_: prev: {
      wallpapers = inputs.wallpapers.packages.${prev.system}.default;

      myDotfiles = inputs.dotfiles.packages.${prev.system}.default;

      rofi =
        if config.cyanea.graphical.hyprland.enable
        then prev.rofi-wayland
        else prev.rofi;

      ncmpcpp = prev.ncmpcpp.override {
        visualizerSupport = true;
        clockSupport = true;
      };

      cava = prev.cava.override {
        withSDL2 = true;
      };
    })
  ];
in {
  nixpkgs.overlays = overlays;
  home-manager.users."${lib.user.name}".nixpkgs.overlays = overlays;
}
