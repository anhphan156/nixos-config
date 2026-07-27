{
  flake.nixosModules.sudo = {
    security.sudo = {
      enable = true;
      wheelNeedsPassword = false;
    };
  };
}
