{
  description = "Nixos config flake";

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    user = rec {
      name = "backspace";
      git_name = "anhphan";
      git_email = "anh.phan156@protonmail.com";
      path = {
        root = ./.;
        dev = "/home/${name}/data/dev";
        dotfiles = "/home/${name}/dotfiles";
        music = "/home/${name}/data/Music";
      };
    };

    lib = nixpkgs.lib.extend (import ./libs {inherit inputs user;});

    forAllSystems = lib.genAttrs lib.platforms.linux;
  in {
    nixosConfigurations = import ./hosts {inherit inputs lib user;};

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

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lua-pam.url = "github:anhphan156/lua-pam";

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

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

    impermanence = {
      url = "github:nix-community/impermanence";
    };

    xremap.url = "github:xremap/nix-flake";
    catppuccin.url = "github:catppuccin/nix";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    wallpapers.url = "github:anhphan156/Wallpapers";
    pre-commit-hooks.url = "github:cachix/git-hooks.nix";
  };
}
