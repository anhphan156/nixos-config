{
  flake.modules.nixos.core = {
    security.sudo = {
      enable = true;
      wheelNeedsPassword = false;
    };
  };
}
