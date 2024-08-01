{
  description = "Nixos config flake";

  outputs = {nixpkgs, ...} @ inputs: let
    user = {
      name = "backspace";
      real_name = "tbd";
      git_name = "anhphan";
      git_email = "anh.phan156@protonmail.com";
      rootPath = ./.;
    };

    lib = nixpkgs.lib.extend (import ./libs {inherit inputs user;});

		system = "x86_64-linux";
		pkgs = import nixpkgs { inherit system; };
  in {
    nixosConfigurations = import ./hosts {inherit inputs lib user;};

    devShells."${system}".default = pkgs.mkShell {
			shellHook = "exec zsh";
		};

    templates = {
      avr = {
        path = ./templates/avr;
        description = "Avr Project Template";
      };
      arm = {
        path = ./templates/arm;
        description = "Arm Project Template";
      };
    };
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
  };
}
