{
  lib,
  inputs,
  ...
}: let
  commonModules =
    [
      (inputs.src + /overlays)
      (inputs.src + /packages)
      inputs.home-manager.nixosModules.home-manager
      inputs.nixvim.nixosModules.nixvim
      inputs.xremap.nixosModules.default
      inputs.catppuccin.nixosModules.catppuccin
      inputs.dotfiles.nixosModules.default
    ]
    ++ (lib.getNixFiles (inputs.src + /modules));
in {
  installer = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {inherit inputs lib;};
    system = "x86_64-linux";
    modules =
      commonModules
      ++ [
        ./installer
      ];
  };

  vmtest = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {inherit inputs lib;};
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

  backlight = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {inherit inputs lib;};
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

  omega = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {inherit inputs lib;};
    system = "x86_64-linux";
    modules =
      commonModules
      ++ [
        ./omega
        ./omega/hardware-configuration.nix
      ];
  };
  wsl = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {inherit inputs lib;};
    system = "x86_64-linux";
    modules =
      commonModules
      ++ [
        inputs.nixos-wsl.nixosModules.default
        ./wsl
      ];
  };
}
