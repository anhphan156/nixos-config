{
  lib,
  config,
  inputs,
  ...
}: {
  config = lib.mkIf config.cyanea.graphical.gui.enable {
    home-manager.users."${lib.user.name}" = import "${inputs.self}/modules/home-manager/dotfiles/kitty";
  };
}
