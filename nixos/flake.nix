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
        user = {
            name = "backspace";
            real_name = "tbd";
        };

        rootPath = ./.;
    in
    {
        nixosConfigurations = {
            backlight = import ./hosts/backlight { inherit inputs user rootPath; };
        };
    };
}
