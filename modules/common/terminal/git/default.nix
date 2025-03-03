{
  lib,
  inputs,
  ...
}: {
  home-manager.users."${lib.user.name}" = import "${inputs.self}/modules/home-manager/dotfiles/git";
}
