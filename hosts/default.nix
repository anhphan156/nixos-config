{
  lib,
  inputs,
  ...
}: let
  pkgs =
    import inputs.nixpkgs {
      system = "x86_64-linux";
      config = {
        allowUnfree = true;
      };
      overlays = [
        inputs.nvim-config.overlays.default

        (import (inputs.self + /overlays/wrapDesktopItem.nix))
        (import (inputs.self + /overlays/awesome.nix))
        (import (inputs.self + /overlays/misc.nix))

        (_: prev: {
          wallpapers = inputs.wallpapers.packages.${prev.system}.default;
          myDotfiles = inputs.dotfiles.packages.${prev.system}.default;
          rofi = prev.rofi-wayland;
        })
      ];
    }
    // {inherit lib;};

  commonModules =
    [
      (inputs.self + /packages)
      inputs.home-manager.nixosModules.home-manager
      inputs.nixvim.nixosModules.nixvim
      inputs.xremap.nixosModules.default
      inputs.catppuccin.nixosModules.catppuccin
      inputs.dotfiles.nixosModules.default
    ]
    ++ (lib.getNixFiles (inputs.self + /modules));
in {
  installer = pkgs.lib.nixosSystem {
    inherit pkgs;
    specialArgs = {inherit inputs;};
    system = "x86_64-linux";
    modules =
      commonModules
      ++ [
        ./installer
        ./installer/pacman.nix
      ];
  };

  vmtest = pkgs.lib.nixosSystem {
    inherit pkgs;
    specialArgs = {inherit inputs;};
    system = "x86_64-linux";
    modules =
      commonModules
      ++ [
        inputs.disko.nixosModules.default
        inputs.impermanence.nixosModules.impermanence
        ./vmtest
        ./vmtest/hardware-configuration.nix
        ./vmtest/disk-config.nix
      ];
  };

  backlight = pkgs.lib.nixosSystem {
    inherit pkgs;
    specialArgs = {inherit inputs;};
    system = "x86_64-linux";
    modules =
      commonModules
      ++ [
        inputs.disko.nixosModules.default
        inputs.impermanence.nixosModules.impermanence
        ./backlight
        ./backlight/hardware-configuration.nix
        ./backlight/disk-config.nix
      ];
  };

  omega = pkgs.lib.nixosSystem {
    inherit pkgs;
    specialArgs = {inherit inputs;};
    system = "x86_64-linux";
    modules =
      commonModules
      ++ [
        ./omega
        ./omega/hardware-configuration.nix
      ];
  };
  wsl = pkgs.lib.nixosSystem {
    inherit pkgs;
    specialArgs = {inherit inputs;};
    system = "x86_64-linux";
    modules =
      commonModules
      ++ [
        inputs.nixos-wsl.nixosModules.default
        ./wsl
      ];
  };
}
