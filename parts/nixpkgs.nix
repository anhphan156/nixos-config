{inputs, ...}: {
  flake.nixosModules.nixpkgsConfig = {
    nixpkgs.config.allowUnfree = true;
  };
  perSystem = {system, ...}: {
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;
      overlays = [
        inputs.neovim-nightly.overlays.default
      ];
      config = {
        allowUnfree = true;
      };
    };
  };
}
