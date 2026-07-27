{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.tempest = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      tempestConfig

      core
      fancyShell
      desktop
      hyprland
      packages

      nvidia
      faugus
      proton
    ];
  };
}
