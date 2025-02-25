{
  config,
  lib,
  inputs,
  ...
}: {
  options.cyanea.graphical.mako.enable = lib.mkEnableOption "Enable Mako";
  config = lib.mkIf config.cyanea.graphical.mako.enable {
    home-manager.users.${lib.user.name} = import "${inputs.self}/modules/home-manager/dotfiles/mako";
  };
}
