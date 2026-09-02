{
  flake.modules.nixos.desktop = { pkgs, ... }: {
    services.udev.packages = [
      pkgs.yubikey-personalization
    ];
  };
}
