{
  flake.modules.nixos.preservation = { config, ... }: {
    systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];
    preservation = {
      enable = true;
      preserveAt."/persistence" = {
        directories = [
          "/var/log"
          "/var/lib/alsa"
          "/var/lib/bluetooth"
          "/var/lib/nixos"
          "/var/lib/systemd"
          "/var/lib/libvirt"
          "/var/lib/sbctl"
          "/var/db/sudo/lectured"
          "/etc/NetworkManager/system-connections"
          {
            directory = "/var/lib/colord";
            user = "colord";
            group = "colord";
            mode = "u=rwx,g=rx,o=";
          }
        ];
        files = [
          {
            file = "/etc/machine-id";
            inInitrd = true;
          }
        ];

        users."${config.username}" = {
          directories = [
            "Downloads"
            "Pictures"
            "Documents"
            "Games"
            "Development"
            "nixos-config"
            ".steam"
            ".config/Signal"
            ".config/librewolf"
            ".config/discord"
            ".config/vesktop"
            ".config/cake_wallet"
            ".local"
            ".cache"
            {
              directory = ".gnupg";
              mode = "0700";
            }
            {
              directory = ".ssh";
              mode = "0700";
            }
            {
              directory = ".password-store";
              mode = "0700";
            }
          ];
        };
      };
    };
  };
}
