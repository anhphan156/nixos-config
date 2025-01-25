{
  description = "Nixos config flake";

  outputs = {
    nixpkgs,
    self,
    ...
  } @ inputs: let
    lib = nixpkgs.lib.extend (import ./libs inputs);
    forAllSystems = lib.genAttrs ["x86_64-linux"];
  in {
    nixosConfigurations = import ./hosts {
      inherit inputs lib;
    };

    homeConfigurations = {
      default = self.nixosConfigurations.backlight.config.home-manager.users.${lib.user.name}.home;
    };

    checks = forAllSystems (system: {
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
    wallpapers.url = "github:anhphan156/Wallpapers";
    dotfiles.url = "github:anhphan156/dotfiles";
    pre-commit-hooks.url = "github:cachix/git-hooks.nix";

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

    alejandra = {
      url = "github:kamadorueda/alejandra";
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
