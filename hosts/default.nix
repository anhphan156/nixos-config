{
  user,
  lib,
  inputs,
  ...
}: let

  commonModules = [
    (user.rootPath + /overlay)
    (user.rootPath + /packages)
    inputs.home-manager.nixosModules.home-manager
    inputs.nixvim.nixosModules.nixvim
    inputs.xremap.nixosModules.default
  ] ++ 
	  (lib.getNixFiles (user.rootPath + /modules));
in {
  installer = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {inherit inputs user lib;};
    system = "x86_64-linux";
    modules = [
      (user.rootPath + /modules)
      inputs.home-manager.nixosModules.home-manager
      inputs.nixvim.nixosModules.nixvim
      inputs.xremap.nixosModules.default
      ./installer
    ];
  };

  vmtest = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {inherit inputs user lib;};
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
    specialArgs = {inherit inputs user lib;};
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
    specialArgs = {inherit inputs user lib;};
    system = "x86_64-linux";
    modules =
      commonModules
      ++ [
        ./omega
        ./omega/hardware-configuration.nix
      ];
  };
}
