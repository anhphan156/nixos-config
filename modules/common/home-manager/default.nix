{
  lib,
  specialArgs,
  ...
}: {
  home-manager = {
    useGlobalPkgs = true;
    extraSpecialArgs = specialArgs;
    users."${lib.user.name}" = import "${specialArgs.inputs.self}/modules/home-manager/home.nix";
  };
}
