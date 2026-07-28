{
  flake.nixosModules.nixld = {
    programs.nix-ld = {
      enable = true;
    };
  };
}
