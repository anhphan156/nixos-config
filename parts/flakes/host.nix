{
  lib,
  inputs,
  config,
  self,
  ...
}:
let
  host = { config, ... }: {
    options = {
      general = lib.mkOption {
        type = with lib.types; listOf deferredModule;
        default = [ ];
      };
      desktop = lib.mkOption {
        type = with lib.types; listOf deferredModule;
        default = [ ];
      };
      gaming = lib.mkOption {
        type = with lib.types; listOf deferredModule;
        default = [ ];
      };
      pkgs = lib.mkOption {
        type = lib.types.pkgs;
      };
      system = lib.mkOption {
        type = lib.types.str;
      };
    };

    config = {
      pkgs = import inputs.nixpkgs {
        inherit (config) system;
        config.allowUnfree = true;
        overlays = [
          (_: _: {
            inherit (self.packages.${config.system}) zathura yazi;
          })
        ];
      };
    };
  };
in
{
  options.nixosHosts = lib.mkOption {
    type = with lib.types; attrsOf (submodule host);
    default = { };
  };

  config = {
    flake.nixosConfigurations = lib.mapAttrs (
      _: options:
      inputs.nixpkgs.lib.nixosSystem {
        inherit (options) pkgs;
        modules = with options; general ++ desktop ++ gaming;
      }
    ) config.nixosHosts;
  };
}
