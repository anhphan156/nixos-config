{
  lib,
  specialArgs,
  ...
}: {
  home-manager = {
    useGlobalPkgs = true;
    extraSpecialArgs = specialArgs;
    users."${lib.user.name}".imports = [
      "${specialArgs.inputs.self}/modules/home-manager/home.nix"
      "${specialArgs.inputs.self}/modules/home-manager/users/backspace"
    ];
  };
}
