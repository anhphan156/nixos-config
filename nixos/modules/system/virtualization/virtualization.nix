{ lib, config, user, ... }:
{
    options = {
        virtualization.enable = lib.mkEnableOption "enable virtualization";
    };

    config = lib.mkIf config.virtualization.enable {
        virtualisation.libvirtd.enable = true;
        virtualisation.libvirtd.allowedBridges = [
            "virbr0"
        ];
        programs.virt-manager.enable = true;

        home-manager.users."${user.name}".dconf.settings = {
            "org/virt-manager/virt-manager/connections" = {
                autoconnect = ["qemu:///system"];
                uris = ["qemu:///system"];
            };
        };
    };
}
