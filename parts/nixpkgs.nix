{ inputs, moduleWithSystem, ... }: {
  flake.nixosModules.nixpkgsConfig = moduleWithSystem (
    { self', ... }: {
      nixpkgs.config.allowUnfree = true;
      nixpkgs.overlays = [
        (_: _: {
          inherit (self'.packages) zathura;
        })
      ];
    }
  );
  perSystem =
    {
      system,
      ...
    }:
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = [
          inputs.neovim-nightly.overlays.default
          (_: prev: {
            wallpapers = "${inputs.dotfiles}/misc/wallpapers";
          })
        ];
        config = {
          allowUnfree = true;
        };
      };
    };
}
