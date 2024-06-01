{
  lib,
  config,
  user,
  pkgs,
  ...
}: {
  options = {
    cyanea.virtualization.enable = lib.mkEnableOption "enable virtualization";
  };

  config = lib.mkIf config.cyanea.virtualization.enable {
    virtualisation.libvirtd.enable = true;
    virtualisation.libvirtd.allowedBridges = [
      "virbr0"
    ];
    programs.virt-manager.enable = true;

    users.users."${user.name}" = {
      extraGroups = lib.mkAfter ["libvirtd"];
    };

    home-manager.users."${user.name}" = {
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
