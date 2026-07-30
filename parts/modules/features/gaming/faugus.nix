{
  flake.nixosModules.faugus = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      faugus-launcher
    ];
  };
}
