{ self, inputs, ... }: {
  nixosHosts.aether = {
    system = "aarch64-linux";
    general =
      with self.modules.nixos;
      [
        (import ./_config)
        shell
        tailscale
      ]
      ++ [
        "${inputs.nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"
        inputs.nixos-hardware.nixosModules.raspberry-pi-4
      ];
  };

  perSystem = {
    packages.aether = self.nixosConfigurations.aether.config.system.build.sdImage;
  };
}
