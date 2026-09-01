{ self, inputs, ... }: {
  nixosHosts.aether = {
    system = "aarch64-linux";
    general = [
      (import ./_config)
      "${inputs.nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"
      inputs.nixos-hardware.nixosModules.raspberry-pi-4
    ]
    ++ (with self.modules.nixos; [
      shell
      caddy
      jellyfin
    ]);
  };

  perSystem = {
    packages.aether = self.nixosConfigurations.aether.config.system.build.sdImage;
  };
}
