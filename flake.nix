{
  description = "Nixos config flake";

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    user = {
      name = "backspace";
      real_name = "tbd";
			git_name = "anhphan";
			git_email = "anh.phan156@protonmail.com";
    };

    rootPath = ./.;
  in {
    nixosConfigurations = {
      backlight = import ./hosts/backlight {inherit inputs user rootPath;};
      omega = import ./hosts/omega {inherit inputs user rootPath;};
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
  };
}