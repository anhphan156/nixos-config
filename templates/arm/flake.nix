# nix flake init -t github:anhphan156/dotfiles#arm
{
  description = "Arm Project Template";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
  outputs = {
    self,
    nixpkgs,
    ...
  }: let
    pkgs = import nixpkgs {inherit system;};
    system = "x86_64-linux";
  in {
    devShells."${system}".default = pkgs.mkShell {
      buildInputs = with pkgs; [
        pkgsCross.arm-embedded.buildPackages.gcc
        pkgsCross.armv7l-hf-multiplatform.buildPackages.gcc
        pkgsCross.armv7l-hf-multiplatform.glibc.static
      ];
      shellHook = ''
        exec zsh
      '';
    };
  };
}
