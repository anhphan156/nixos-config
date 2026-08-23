{
  flake.modules.nixos.tailscale = {
    services.tailscale = {
      enable = true;
    };

    preservation.preserveAt."/persistence" = {
      directories = [
        "/var/lib/tailscale"
      ];
    };
  };
}
