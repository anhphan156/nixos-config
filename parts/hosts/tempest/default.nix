{
  inputs,
  self,
  ...
}:
{
  flake.nixosConfigurations.tempest = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      # host main
      tempestConfig

      # laptop
      battery
      light

      # components
      core
      fancyShell
      desktop
      hyprland
      packages

      # gaming
      nvidia
      faugus
      proton

      # tools
      binaryAnalysis
    ];
  };
}
