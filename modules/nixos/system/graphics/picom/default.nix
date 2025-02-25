{
  config,
  lib,
  inputs,
  ...
}: let
  cfg = config.cyanea.graphical;
in {
  options = {
    cyanea.graphical.picom.enable = lib.mkEnableOption "Enable picom";
  };

  config = lib.mkIf (cfg.gui.enable && cfg.picom.enable) {
    home-manager.users."${lib.user.name}" = import "${inputs.self}/modules/home-manager/dotfiles/picom";
  };
}
