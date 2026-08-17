{
  inputs,
  self,
  ...
}:
{
  nixosHosts.tempest = {
    system = "x86_64-linux";
    general = with self.modules.nixos; [
      tempest
      preservation
      shell
      nvidia
      dev
      libvirt
    ];

    desktop = with self.modules.nixos; [
      desktop
      sddm
      noctalia
      niri
    ];

    gaming = with self.modules.nixos; [
      faugus
      proton
    ];
  };

  flake.modules.nixos.tempest =
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
      ];

      config = {
        networking.hostName = "tempest";

        niri = {
          outputs = {
            "eDP-1" = {
              mode = "1920x1080";
              scale = 1.0;
              background-color = "#333333";
              position = {
                _attrs = {
                  x = 0;
                  y = 0;
                };
              };
              hot-corners = {
                off = null;
              };
            };
          };
        };

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
          kernelPackages = pkgs.linuxPackages_latest;
          kernelModules = [ "kvm-intel" ];
          extraModulePackages = [ ];
        };

        nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
        hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
        hardware.graphics.enable32Bit = true;

        system.stateVersion = "26.05";

        users.users."${config.username}" = {
          extraGroups = lib.mkAfter [ "video" ];
          initialPassword = "123";
        };

        # impermance
        services.udev.extraRules = ''
          SUBSYSTEM=="backlight", ACTION=="add", KERNEL=="intel_backlight", ATTR{brightness}="2400"
        '';

        fileSystems."/persistence".neededForBoot = true;
        fileSystems."/nix".neededForBoot = true;

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
        }; # disko end
      };
    };

}
