{
  lib,
  config,
  pkgs,
  ...
}: {
  options.cyanea.system.pluggableDevices.sdcard.enable = lib.mkEnableOption "Automount sdcard";
  config = lib.mkIf config.cyanea.system.pluggableDevices.sdcard.enable {
    services.udev.extraRules = ''
      ACTION=="add", KERNEL=="sd[a-z]1", ENV{ID_FS_UUID}=="E088-A06A", RUN+="${pkgs.systemd}/bin/systemd-mount --no-block --automount=yes --collect /dev/%k /mnt"
    '';
  };
}
