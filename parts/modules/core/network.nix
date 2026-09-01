{
  flake.modules.nixos.core =
    {
      config,
      lib,
      ...
    }:
    {
      options = {
        caddyUrl = lib.mkOption {
          type = lib.types.str;
          default = "localhost";
          description = "Default url for webserver";
        };
      };

      config = {
        networking = {
          networkmanager.enable = true;
          networkmanager.dns = lib.mkForce "none";

          firewall.enable = true;
          nftables.enable = true;

          useDHCP = false;
          dhcpcd.enable = false;

          nameservers = [
            "9.9.9.9"
          ];
        };

        services.dnscrypt-proxy = {
          enable = true;
          settings = {
            ipv6_servers = true;
            require_dnssec = true;
            sources.public-resolvers = {
              urls = [
                "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
                "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
              ];
              cache_file = "/var/lib/dnscrypt-proxy2/public-resolvers.md";
              minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
            };
          };
        };

        systemd.services.dnscrypt-proxy2.serviceConfig = {
          StateDirectory = "dnscrypt-proxy";
        };

        users.users."${config.username}" = {
          extraGroups = lib.mkAfter [ "networkmanager" ];
        };
      };
    };
}
