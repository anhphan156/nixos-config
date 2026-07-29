{ inputs, moduleWithSystem, ... }: {

  flake.nixosModules.noctalia = moduleWithSystem (
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
      lib,
      ...
    }:
    {
      packages.noctalia =
        (inputs.wrappers.wrapperModules.noctalia.apply {
          inherit pkgs;
          package = pkgs.noctalia;
          settings = (lib.fromTOML <| builtins.readFile "${inputs.dotfiles}/config/noctalia/config.toml") // {
            wallpaper = {
              directory = "${inputs.dotfiles}/misc/wallpapers/single";
              automation = {
                enabled = true;
                interval_seconds = 300;
              };
            };
          };
        }).wrapper;
    };
}
