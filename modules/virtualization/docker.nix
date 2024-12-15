{
  lib,
  config,
  ...
}: {
  options.cyanea.virtualization.docker = {
    enable = lib.mkEnableOption "Enable Docker";
    btrfs = lib.mkEnableOption "Enable Docker btrfs";
  };

  config = lib.mkIf config.cyanea.virtualization.docker.enable {
    virtualisation.docker = {
      enable = true;
      storageDriver = lib.mkIf config.cyanea.virtualization.docker.btrfs "btrfs";
      daemon.settings = {
        data-root = "/home/backspace/data/docker";
      };
    };
    users.users."${lib.user.name}" = {
      extraGroups = lib.mkAfter ["docker"];
    };
  };
}
