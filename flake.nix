{
  description = "Nixos config flake";

  outputs = {nixpkgs, ...} @ inputs: let
    lib = nixpkgs.lib.extend (import ./libs {inherit inputs;});

    forAllSystems = lib.genAttrs lib.platforms.linux;
  in {
    src = ./.;

    nixosConfigurations = import ./hosts {inherit inputs lib;};

    checks = forAllSystems (system: {
      pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
        src = ./.;
        hooks = {
          alejandra = {
            enable = true;
          };
        };
      };
    });
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    lua-pam.url = "github:anhphan156/lua-pam";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    impermanence.url = "github:nix-community/impermanence";
    xremap.url = "github:xremap/nix-flake";
    catppuccin.url = "github:catppuccin/nix";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    wallpapers.url = "github:anhphan156/Wallpapers";
    eww-config.url = "github:anhphan156/eww-config";
    pre-commit-hooks.url = "github:cachix/git-hooks.nix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    alejandra = {
      url = "github:kamadorueda/alejandra/3.0.0";
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
  };
}
