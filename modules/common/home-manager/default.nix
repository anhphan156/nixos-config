{
  lib,
  specialArgs,
  ...
}: let
  self = specialArgs.inputs.self;
in {
  home-manager = {
    useGlobalPkgs = true;
    extraSpecialArgs = specialArgs;
    users."${lib.user.name}".imports = [
      "${self}/modules/home-manager/home.nix"
      "${self}/modules/home-manager/users/${lib.user.name}"
    ];
  };
}
