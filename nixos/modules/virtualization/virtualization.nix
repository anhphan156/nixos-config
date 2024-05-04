{
    virtualisation.libvirtd.enable = true;
    virtualisation.libvirtd.allowedBridges = [
      "virbr0"
    ];
    programs.virt-manager.enable = true;
}
