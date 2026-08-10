{
  flake.nixosModules.gnupg = { pkgs, ... }: {
    services.udev.packages = [
      pkgs.yubikey-personalization
    ];
    programs.gnupg = {
      package = pkgs.gnupg;
      agent = {
        enable = true;
        enableSSHSupport = true;
        pinentryPackage = pkgs.pinentry-qt;
        settings = {
          default-cache-ttl = 86400;
          max-cache-ttl = 86400;
        };
      };
    };
  };
}
