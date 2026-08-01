{ inputs, ... }: {
  flake.nixosModules.commonPreservation = { config, ... }: {
    imports = [
      inputs.preservation.nixosModules.default
    ];

    systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];
    preservation = {
      enable = true;
      preserveAt."/persistence" = {
        directories = [
          "/var/log"
          "/var/lib/alsa"
          "/var/lib/bluetooth"
          "/var/lib/nixos"
          "/var/lib/systemd/coredump"
          "/var/lib/libvirt"
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

        users."${config.constants.username}" = {
          directories = [
            "data"
            "Downloads"
            "Pictures"
            "Documents"
            "Games"
            "Development"
            "nixos-config"
            ".steam"
            ".config/librewolf"
            ".config/discord"
            ".local/share/Steam"
            ".local/share/zathura"
            ".local/share/direnv"
            ".local/share/zsh"
            ".local/share/zoxide"
            ".local/share/nvim-custom"
            ".local/share/applications"
            ".local/state/noctalia"
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
