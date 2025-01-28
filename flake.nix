{
  description = "Nixos config flake";

  outputs = {
    nixpkgs,
    self,
    ...
  } @ inputs: let
    lib = nixpkgs.lib.extend (import ./libs inputs);
    forAllSystems = lib.genAttrs ["x86_64-linux"];

    pkgs =
      import inputs.nixpkgs {
        system = "x86_64-linux";
        config = {
          allowUnfree = true;
        };
        overlays =
          [
            inputs.nvim-config.overlays.default
            (_: prev: {
              wallpapers = inputs.wallpapers.packages.${prev.system}.default;
              myDotfiles = inputs.dotfiles.packages.${prev.system}.default;
            })
          ]
          ++ (./overlays |> lib.getNixFiles |> map import);
      }
      // {inherit lib;};
  in {
    nixosConfigurations = let
      commonModules =
        [
          ./packages
          inputs.home-manager.nixosModules.home-manager
          inputs.nixvim.nixosModules.nixvim
          inputs.xremap.nixosModules.default
          inputs.catppuccin.nixosModules.catppuccin
          inputs.dotfiles.nixosModules.default
          inputs.disko.nixosModules.default
          inputs.impermanence.nixosModules.impermanence
          inputs.nixos-wsl.nixosModules.default
        ]
        ++ (lib.getNixFiles ./modules);

      forAllHosts = ./hosts |> builtins.readDir |> lib.filterAttrs (k: v: v == "directory") |> lib.mapAttrsToList (k: _: k);

    in lib.genAttrs forAllHosts (host: pkgs.lib.nixosSystem {
        inherit pkgs;
        inherit (pkgs) system;
        specialArgs = {inherit inputs;};
        modules = commonModules ++ (lib.getNixFiles "${self}/hosts/${host}");
    });

    homeConfigurations = {
      default = self.nixosConfigurations.omega.config.home-manager.users.${lib.user.name}.home;
    };

    checks = forAllSystems (system: let
      testArgs = {inherit inputs lib pkgs;};
    in {
      live-usb-test = import ./tests/liveusb.nix testArgs;

      pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
        src = ./.;
        hooks = {
          alejandra = {
            enable = false;
          };
        };
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

    wallpapers = {
      url = "github:anhphan156/Wallpapers";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dotfiles = {
      url = "github:anhphan156/dotfiles";
      inputs.wallpapers.follows = "wallpapers";
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
