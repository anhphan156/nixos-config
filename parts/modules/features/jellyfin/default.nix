{
  flake.modules.nixos.jellyfin = { config, lib, ... }: {
    services.jellyfin = {
      enable = true;
      openFirewall = false;
      user = config.username;
    };

    services.caddy = {
      virtualHosts.${config.caddyUrl}.extraConfig = lib.mkAfter ''
        redir /jellyfin /jellyfin/ 308
        handle_path /jellyfin/* {
            tls internal
            reverse_proxy 127.0.0.1:8096
        }
      '';
    };

    preservation.preserveAt."/persistence" = {
      directories = [
        {
          directory = "/var/lib/jellyfin";
          user = config.username;
          group = config.username;
          mode = "0750";
        }
      ];
    };
  };
}
