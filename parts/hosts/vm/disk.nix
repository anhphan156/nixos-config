{inputs, ...}: {
  flake.nixosModules.vmDisk = {
    # sudo nix --extra-experimental-features "nix-command flakes" run 'github:nix-community/disko/latest#disko-install' -- --option extra-experimental-features "pipe-operators" --flake 'flake-url#vm' --disk <disk-name> /dev/<device-name>
    imports = [
      inputs.disko.nixosModules.default
    ];
    disko.devices.nodev."/" = {
      fsType = "tmpfs";
      mountOptions = ["size=2G" "defaults" "mode=775"];
    };
    disko.devices.disk.main = {
      type = "disk";
      device = "/dev/vda";
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
                extraArgs = ["-f"];
                subvolumes = {
                  "/persistence" = {
                    mountpoint = "/persistence";
                    mountOptions = ["compress=zstd" "noatime"];
                  };
                  "/nix" = {
                    mountpoint = "/nix";
                    mountOptions = ["compress=zstd" "noatime"];
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
}
