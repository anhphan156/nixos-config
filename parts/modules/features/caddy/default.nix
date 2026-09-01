{
  flake.modules.nixos.caddy = { lib, config, ... }: {
    config = {
      services.tailscale.permitCertUid = "caddy";
      services.caddy = {
        enable = true;
        virtualHosts.${config.caddyUrl}.extraConfig = lib.mkBefore ''
          handle_path / {
            reverse_proxy duckduckgo.com
          }
        '';
      };
    };
  };
}
