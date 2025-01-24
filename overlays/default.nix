{
  lib,
  inputs,
  config,
  ...
}: let
  overlays = [
    inputs.nvim-config.overlays.default
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

      awesome = prev.awesome.overrideAttrs (oa: {
        version = "14g9kp2x17fsx81lxfgl2gizwjwmfpsfqi5vdwv5iwa35v11dljn";
        src = prev.fetchFromGitHub {
          owner = "awesomeWM";
          repo = "awesome";
          rev = "8b1f8958b46b3e75618bc822d512bb4d449a89aa";
          sha256 = "0a140ixasiyzyr6axd5akjcgdgx58pn2kqdgy9ag6hczhpf7jrk4";
        };
        patches = [];
        postPatch = ''
          patchShebangs tests/examples/_postprocess.lua
        '';
      });
    })
  ];
in {
  nixpkgs.overlays = overlays;
  home-manager.users."${lib.user.name}".nixpkgs.overlays = overlays;
}
