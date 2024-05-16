{ lib, config, ... }:
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
    };
}
