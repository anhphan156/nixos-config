{
  flake.nixosModules.libvirt =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      virtualisation = {
        libvirtd = {
          enable = true;
          allowedBridges = [
            "virbr0"
          ];
          qemu = {
            package = pkgs.qemu_kvm;
          };
        };

        spiceUSBRedirection.enable = true;
      };

      programs.virt-manager.enable = true;

      users.users."${config.constants.username}" = {
        extraGroups = lib.mkAfter [ "libvirtd" ];
      };

      # programs.dconf = {
      #   enable = true;
      #   settings = {
      #     "org/virt-manager/virt-manager/connections" = {
      #       autoconnect = [ "qemu:///system" ];
      #       uris = [ "qemu:///system" ];
      #     };
      #   };
      # };
    };
}
