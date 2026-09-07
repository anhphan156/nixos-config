{ self, ... }: {
  nixosHosts.gale = {
    system = "x86_64-linux";
    general = with self.modules.nixos; [
      (import ./_config)
      openssh
      shell
      dev
      neovim
      gnupg
    ];

    desktop = with self.modules.nixos; [
      desktop
      sddm
      noctalia
      niri
    ];
  };

  perSystem.packages.gale = self.nixosConfigurations.gale.config.system.build.isoImage;
}
