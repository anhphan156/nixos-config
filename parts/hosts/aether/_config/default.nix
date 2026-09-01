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
    nftables = {
      enable = true;
      ruleset = ''
        table inet mullvad_tailscale {
        	chain output {
        		type route hook output priority -100; policy accept;

        		# Bypass Mullvad for traffic addressed to Tailscale.
        		ip daddr 100.64.0.0/10 counter ct mark set 0x00000f41 meta mark set 0x6d6f6c65
        		ip6 daddr fd7a:115c:a1e0::/48 counter ct mark set 0x00000f41 meta mark set 0x6d6f6c65
        	}

        	chain input {
        		type filter hook input priority -100; policy accept;

        		# Mark only traffic that actually arrived through Tailscale.
        		iifname "tailscale0" ip saddr 100.64.0.0/10 counter ct mark set 0x00000f41 meta mark set 0x6d6f6c65
        		iifname "tailscale0" ip6 saddr fd7a:115c:a1e0::/48 counter ct mark set 0x00000f41 meta mark set 0x6d6f6c65
        	}
        }
      '';
    };

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
