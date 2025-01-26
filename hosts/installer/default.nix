#nix build .#nixosConfigurations.installer.config.system.build.isoImage
{
  modulesPath,
  lib,
  inputs,
  ...
}: {
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    ./configuration.nix
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}