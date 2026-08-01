{
  flake.nixosModules.gnupg = { pkgs, ... }: {
    programs.gnupg = {
      package = pkgs.gnupg;
      agent = {
        enable = true;
        pinentryPackage = pkgs.pinentry-qt;
      };
    };
  };
}
