{
  lib,
  pkgs,
  config,
  ...
}:
{
  caddyUrl = "aether.rainbow-exponential.ts.net";

  sdImage.compressImage = false;

  users.users.${config.username}.initialPassword = "123";

  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };
  boot.kernelPackages = pkgs.linuxPackages;
  boot.supportedFilesystems.zfs = lib.mkForce false;

  hardware.raspberry-pi.firmware = {
    enable = true;
    uboot.enable = true;
  };

  networking.firewall.checkReversePath = "loose"; # For tailscale exit node

  system.stateVersion = "26.05";
}
