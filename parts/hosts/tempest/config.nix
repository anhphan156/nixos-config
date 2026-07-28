{ inputs, ... }: {
  flake.nixosModules.tempestConfig =
    {
      modulesPath,
      config,
      lib,
      pkgs,
      ...
    }:
    {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
        inputs.disko.nixosModules.default
        inputs.impermanence.nixosModules.impermanence
      ];

      config = {
        hostname = "tempest";

        hyprland.extraConfig = ''
          hl.monitor({
            output   = "eDP-1",
            mode     = "1920x1080",
            position = "0x0",
            scale    = "1.0",
          })

          for i = 1, 4 do
            hl.workspace_rule({ workspace = tostring(i), monitor = "eDP-1" })
          end
        '';

        # hardware
        boot = {
          initrd = {
            availableKernelModules = [
              "xhci_pci"
              "nvme"
              "usb_storage"
              "sd_mod"
              "rtsx_usb_sdmmc"
            ];
            kernelModules = [ ];
          };
          kernelModules = [ "kvm-intel" ];
          extraModulePackages = [ ];
        };

        nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
        hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
        hardware.graphics.enable32Bit = true;

        users.users."${config.constants.username}".initialPassword = "123";
        # impermance
        fileSystems."/persistence".neededForBoot = true;
        environment.persistence."/persistence" = {
          hideMounts = true;
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
            "/etc/machine-id"
          ];
          users."${config.constants.username}" = {
            directories = [
              "data"
              "Downloads"
              ".ssh"
              ".emacs.d"
              ".cargo"
              ".steam"
              ".config/librewolf"
              ".config/faugus-launcher"
              ".local/share/Steam"
              ".local/share/direnv"
              ".local/share/zsh"
              ".local/share/Anki2"
              ".local/share/mpd"
              ".local/share/nvim-custom"
              ".local/share/applications"
              ".local/share/umu"
              ".cache"
            ];
          };
        };

        system.stateVersion = "26.05";

        disko.devices.nodev."/" = {
          fsType = "tmpfs";
          mountOptions = [
            "size=4G"
            "defaults"
            "mode=775"
          ];
        };
        disko.devices.disk.hehe = {
          type = "disk";
          device = "/dev/nvme0n1";
          content = {
            type = "gpt";
            partitions = {
              ESP = {
                size = "512M";
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                  mountOptions = [
                    "defaults"
                  ];
                };
              };
              luks = {
                size = "100%";
                content = {
                  type = "luks";
                  name = "crypted";
                  passwordFile = "/tmp/secret.key";
                  content = {
                    type = "btrfs";
                    extraArgs = [ "-f" ];
                    subvolumes = {
                      "/persistence" = {
                        mountpoint = "/persistence";
                        mountOptions = [
                          "compress=zstd"
                          "noatime"
                        ];
                      };
                      "/nix" = {
                        mountpoint = "/nix";
                        mountOptions = [
                          "compress=zstd"
                          "noatime"
                        ];
                      };
                      "/swap" = {
                        mountpoint = "/.swapvol";
                        swap.swapfile.size = "4G";
                      };
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
}
