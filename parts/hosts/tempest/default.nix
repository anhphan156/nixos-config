{
  self,
  ...
}:
{
  nixosHosts.tempest = {
    system = "x86_64-linux";
    general = with self.modules.nixos; [
      (import ./_config)
      boot
      preservation
      shell
      nvidia
      dev
      neovim
      libvirt
      nixld
      mullvad
    ];

    desktop = with self.modules.nixos; [
      desktop
      sddm
      noctalia
      niri
    ];

    gaming = with self.modules.nixos; [
      faugus
      proton
    ];
  };
}
