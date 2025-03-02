{
  description = "Nixos config flake";

  outputs = {
    nixpkgs,
    self,
    ...
  } @ inputs: let
    lib = nixpkgs.lib.extend <| import ./libs;

    forAllSystems = lib.genAttrs ["x86_64-linux"];
    forAllLinuxHosts = ./hosts/linux |> builtins.readDir |> lib.filterAttrs (_: v: v == "directory") |> lib.mapAttrsToList (k: _: k) |> lib.genAttrs;

    pkgsFor = system:
      import inputs.nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
        overlays =
          [
            inputs.nvim-config.overlays.default
            inputs.wallpapers.overlays.default
            inputs.dotfiles.overlays.default
          ]
          ++ (map import <| lib.getNixFiles ./overlays);
      }
      // {inherit lib;};
  in {
    nixosConfigurations = let
      pkgs = pkgsFor "x86_64-linux";
    in forAllLinuxHosts (host: pkgs.lib.nixosSystem {
      inherit pkgs;
      inherit (pkgs) system;
      specialArgs = {inherit inputs;};
      modules = 
        (lib.getNixFiles "${self}/hosts/linux/${host}")
        ++ (lib.getNixFiles ./modules/common)
        ++ (lib.getNixFiles ./modules/nixos)
        ++ [
          inputs.home-manager.nixosModules.home-manager
          inputs.nixvim.nixosModules.nixvim
          inputs.xremap.nixosModules.default
          inputs.catppuccin.nixosModules.catppuccin
          inputs.dotfiles.nixosModules.default
          inputs.disko.nixosModules.default
          inputs.impermanence.nixosModules.impermanence
          inputs.nixos-wsl.nixosModules.default
        ];
      });

    darwinConfigurations = {
      default = let 
        darwinLib = inputs.nix-darwin.lib.extend <| import ./libs; 
      in darwinLib.darwinSystem rec {
        system = "x86_64-darwin";
        pkgs = pkgsFor system;
        specialArgs = {inherit inputs;};
        modules = 
          (lib.getNixFiles ./modules/darwin)
          ++ (lib.getNixFiles ./modules/common)
          ++ [
            inputs.home-manager.darwinModules.home-manager
            ./hosts/darwin/macbook
          ];
      };
    };

    homeConfigurations = forAllLinuxHosts (host: self.nixosConfigurations.${host}.config.home-manager.users.${lib.user.name}.home);

    checks = forAllSystems (system: {
      pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
        src = ./.;
        hooks = {
          alejandra.enable = false;
        };
      };
    });

    devShells = forAllSystems (system: {
      default = (pkgsFor system).mkShell {
        buildInputs = self.checks.${system}.pre-commit-check.enabledPackages;
        inherit (self.checks.${system}.pre-commit-check) shellHook;
      };
    });
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    lua-pam.url = "github:anhphan156/lua-pam";
    impermanence.url = "github:nix-community/impermanence";
    xremap.url = "github:xremap/nix-flake";
    catppuccin.url = "github:catppuccin/nix";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    pre-commit-hooks.url = "github:cachix/git-hooks.nix";
    wallpapers.url = "github:anhphan156/Wallpapers";

    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dotfiles = {
      url = "github:anhphan156/dotfiles";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvim-config = {
      url = "github:anhphan156/nvim-config";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    archlinux-keyring = {
      url = "https://archlinux.org/packages/core/any/archlinux-keyring/download/";
      flake = false;
    };

    archlinux-mirrorlist = {
      url = "https://archlinux.org/mirrorlist/?country=US&protocol=http&protocol=https&ip_version=4";
      flake = false;
    };
  };
}
