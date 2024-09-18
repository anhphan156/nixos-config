{
  disko.devices = {
    disk = {
      main = {
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
            }; # ESP
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                passwordFile = "/tmp/secret.key";
                content = {
                  type = "filesystem";
                  format = "ext4";
                  mountpoint = "/";
                }; # content
              }; # content
            }; # luks
          }; # partitions
        }; # content
      }; # main
    }; # disk
  }; # disko.devices
}
