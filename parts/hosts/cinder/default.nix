{
  inputs,
  self,
  ...
}:
{
  flake.nixosConfigurations.cinder = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      # host main
      cinderConfig
      commonPreservation

      # components
      core
      desktop
      fancyShell
      packages

      noctaliaGreeter
      noctalia
      niri

      # gaming
      proton
      steam

      # tools
      binaryAnalysis
      dev
      libvirt
    ];
  };

  flake.nixosModules.cinderConfig =
    {
      modulesPath,
      config,
      lib,
      ...
    }:
    {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
      ];

      config = {
        hostname = "cinder";

        desktop = {
          defaultSession = "niri";
          greeterOutput = "DP-3";
        };

        niri = {
          outputs = {
            "DP-3" = {
              mode = "3840x2160@60";
              scale = 1.5;
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
              "ahci"
              "usb_storage"
              "sd_mod"
              "usbhid"
            ];
            kernelModules = [ "dm-snapshot" ];
            luks.devices.cryptroot.device = "/dev/disk/by-uuid/2b1f9642-12a4-44f0-b642-491d9ae9c664";
          };
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
            "size=8G"
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

        users.users."${config.constants.username}".initialPassword = "123";

        system.stateVersion = "26.05";
      };
    };
}
