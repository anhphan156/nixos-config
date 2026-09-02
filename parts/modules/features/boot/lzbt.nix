{
  flake.modules.nixos.lzbt = { lib, ... }: {
    boot = {
      loader.systemd-boot.enable = lib.mkForce false;
      lanzaboote = {
        enable = true;
        pkiBundle = "/var/lib/sbctl";
        autoGenerateKeys.enable = true;
        autoEnrollKeys.enable = true;
        configurationLimit = 3;
        measuredBoot = {
          enable = true;
          pcrs = [
            0
            4
            7
          ];
        };
      };
    };

    preservation.preserveAt."/persistence" = {
      directories = [
        "/var/lib/auto-cryptenroll"
      ];
    };
  };
}
