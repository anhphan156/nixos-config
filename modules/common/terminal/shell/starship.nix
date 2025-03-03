{
  inputs,
  lib,
  ...
}: {
  home-manager.users."${lib.user.name}" = import "${inputs.self}/modules/home-manager/dotfiles/shell/starship.nix";
}
