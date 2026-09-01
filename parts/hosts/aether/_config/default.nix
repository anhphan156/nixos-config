{
  lib,
  pkgs,
  config,
  ...
}:
{
  services.mullvad-vpn = {
    enable = true;
    gui.enable = false;
  };

  caddyUrl = "aether.rainbow-exponential.ts.net";

  sdImage.compressImage = false;

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

  networking = {
    firewall = {
      allowedTCPPorts = [
        22
      ];
    };
    nameservers = [
      "9.9.9.9"
    ];
  };

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "prohibit-password";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  users.users.${config.username} = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB82m11CRIDRpMb2+XyvsOYjekaCvKJL3lN+nZf3rYla openpgp:0x86A78EF3"
    ];
  };

  system.stateVersion = "26.05";
}
