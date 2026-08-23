{
  flake.modules.nixos.caddy = { lib, ... }: {
    services.tailscale.permitCertUid = "caddy";
    services.caddy = {
      enable = true;
      virtualHosts."cinder.rainbow-exponential.ts.net".extraConfig = lib.mkBefore ''
        handle_path / {
          reverse_proxy duckduckgo.com
        }
      '';
    };
  };
}
