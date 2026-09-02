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
      general = [
        self.modules.nixos.core
      ];
      pkgs = import inputs.nixpkgs {
        inherit (config) system;
        config.allowUnfree = true;
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
      host: options:
      inputs.nixpkgs.lib.nixosSystem {
        inherit (options) pkgs;
        modules =
          with inputs;
          [
            disko.nixosModules.default
            preservation.nixosModules.default
            lanzaboote.nixosModules.lanzaboote
            { networking.hostName = host; }
          ]
          ++ (with options; general ++ desktop ++ gaming);
      }
    ) config.nixosHosts;
  };
}
