{ inputs, ... }: {
  systems = [
    "x86_64-linux"
    "aarch64-linux"
  ];

  imports = [
    inputs.flake-parts.flakeModules.modules
  ];

  perSystem =
    {
      system,
      ...
    }:
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = [
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
