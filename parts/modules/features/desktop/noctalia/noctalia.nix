{ inputs, moduleWithSystem, ... }: {

  flake.modules.nixos.noctalia = moduleWithSystem (
    { self', ... }: {
      imports = [
        # inputs.noctalia.nixosModules.default
      ];

      programs.noctalia = {
        enable = true;
        package = self'.packages.noctalia;
        systemd.enable = true;
        recommendedServices.enable = true;
      };
    }
  );

  perSystem =
    {
      pkgs,
      ...
    }:
    {
      packages.noctalia =
        (inputs.wrappers.wrapperModules.noctalia.apply {
          inherit pkgs;
          package = pkgs.noctalia;
          settings = import ./_config {
            wallpapersDir = "${inputs.dotfiles}/misc/wallpapers/single";
          };
        }).wrapper;
    };
}
