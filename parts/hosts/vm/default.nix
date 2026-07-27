{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.vm = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      vmMisc
      vmDisk

      core
      fancyShell
      desktop
      hyprland
      packages
    ];
  };

  flake.nixosModules.vmMisc = {
    config,
    modulesPath,
    lib,
    pkgs,
    ...
  }: {
    # lighting
    services.udev.extraRules = ''
      SUBSYSTEM=="backlight", ACTION=="add", KERNEL=="intel_backlight", ATTR{brightness}="2400"
    '';
    environment.systemPackages = with pkgs; [
      brightnessctl
      acpilight
    ];
    users.users."${config.constants.username}" = {
      extraGroups = lib.mkAfter ["video"];
      initialPassword = "123";
    };

    # hardware
    imports = [
      (modulesPath + "/profiles/qemu-guest.nix")
      inputs.impermanence.nixosModules.impermanence
    ];

    boot = {
      initrd = {
        availableKernelModules = ["xhci_pci" "ahci" "virtio_pci" "sr_mod" "virtio_blk"];
        kernelModules = [];
      };
      kernelModules = ["kvm-amd"];
      extraModulePackages = [];
    };

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

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

    # users.users."${config.constants.username}".initialPassword = "123";

    system.stateVersion = "26.05";
  };
}
