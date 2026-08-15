{
  flake.modules.nixos.proton = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      protonup-ng
      protonplus
    ];
  };
}
