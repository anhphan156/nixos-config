{
  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;}
    (inputs.import-tree ./parts);

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:denful/import-tree";
    wrappers.url = "github:BirdeeHub/nix-wrapper-modules";
    impermanence.url = "github:nix-community/impermanence";
    neovim-nightly = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dotfiles = {
      url = "github:anhphan156/dotfiles";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mscreenshot = {
      url = "git+https://github.com/anhphan156/mscreenshot";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
