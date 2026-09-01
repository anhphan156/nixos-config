{
  self,
  ...
}:
{
  nixosHosts.cinder = {
    system = "x86_64-linux";
    general = with self.modules.nixos; [
      cinder
      boot
      preservation
      shell
      neovim
      dev
      libvirt
      nixld
      mullvad
    ];

    desktop = with self.modules.nixos; [
      desktop
      noctaliaGreeter
      noctalia
      niri
    ];

    gaming = with self.modules.nixos; [
      proton
      steam
    ];
  };

  flake.modules.nixos.cinder =
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
      ];

      config = {
        services.xserver.videoDrivers = [ "amdgpu" ];
        boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

        greeterOutput = "DP-3";
        niri = {
          outputs = {
            "DP-3" = {
              mode = "1920x1080@60";
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

        preservation.preserveAt."/persistence" = {
          users."${config.username}" = {
            directories = [
              ".config/unity3d"
            ];
          };
        };

        # hardware
        boot = {
          initrd = {
            availableKernelModules = [
              "xhci_pci"
              "nvme"
              "ahci"
              "usb_storage"
              "sd_mod"
              "usbhid"
            ];
            kernelModules = [ "dm-snapshot" ];
            luks.devices.cryptroot.device = "/dev/disk/by-uuid/2b1f9642-12a4-44f0-b642-491d9ae9c664";
          };
          kernelPackages = pkgs.linuxPackages_latest;
          kernelModules = [ "kvm-amd" ];
          extraModulePackages = [ ];
        };

        nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
        hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
        hardware.graphics.enable32Bit = true;

        fileSystems."/" = {
          device = "none";
          fsType = "tmpfs";
          options = [
            "size=4G"
            "mode=755"
          ];
        };
        fileSystems."/nix" = {
          device = "/dev/mapper/vg0-nix";
          fsType = "ext4";
          neededForBoot = true;
        };
        fileSystems."/persistence" = {
          device = "/dev/mapper/vg0-persistence";
          fsType = "ext4";
          neededForBoot = true;
        };
        fileSystems."/boot" = {
          device = "/dev/disk/by-uuid/4ED6-72C1";
          fsType = "vfat";
          options = [
            "fmask=0022"
            "dmask=0022"
          ];
        };
        swapDevices = [ { device = "/dev/mapper/vg0-swap"; } ];

        users.users."${config.username}".initialPassword = "123";

        system.stateVersion = "26.05";
      };
    };
}
