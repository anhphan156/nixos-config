{
  description = "Nixos config flake";

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
  };

  outputs = { self, nixpkgs, ... }@inputs: 
    let
      #system = "x86_64-linux";
      #pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        system = "x86_64-linux";
        modules = [
          ./hosts/default/configuration.nix
          inputs.home-manager.nixosModules.default
        ];
      };
    };
}
