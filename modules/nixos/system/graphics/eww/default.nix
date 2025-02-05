{
  config,
  lib,
  inputs,
  ...
}: {
  options.cyanea.graphical.eww.enable = lib.mkEnableOption "Enable Eww";

  config = lib.mkIf config.cyanea.graphical.eww.enable {
    home-manager.users."${lib.user.name}" = import "${inputs.self}/modules/home-manager/dotfiles/eww";
  };
}
