{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    cyanea.virtualization.libvirt.enable = lib.mkEnableOption "enable virtualization";
  };

  config = lib.mkIf config.cyanea.virtualization.libvirt.enable {
    virtualisation = {
      libvirtd = {
        enable = true;
        allowedBridges = [
          "virbr0"
        ];
        qemu = {
          swtpm.enable = true;
          ovmf = {
            enable = true;
            packages = [
              (pkgs.OVMF.override {
                secureBoot = true;
                tpmSupport = true;
              })
              .fd
            ];
          };
        };
      };
      spiceUSBRedirection = lib.enabled;
    };

    programs.virt-manager.enable = true;

    users.users."${lib.user.name}" = {
      extraGroups = lib.mkAfter ["libvirtd"];
    };

    home-manager.users."${lib.user.name}" = {
      home.pointerCursor = lib.mkIf config.cyanea.graphical.hyprland.enable {
        gtk.enable = true;
        package = pkgs.vanilla-dmz;
        name = "Vanilla-DMZ";
      };
      dconf.settings = {
        "org/virt-manager/virt-manager/connections" = {
          autoconnect = ["qemu:///system"];
          uris = ["qemu:///system"];
        };
      };
    };
  };
}
