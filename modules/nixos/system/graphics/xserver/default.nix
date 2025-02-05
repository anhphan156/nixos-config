{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.cyanea.graphical;
in {
  options = {
    cyanea.graphical.xsv.enable = lib.mkEnableOption "Enable Xserver";
  };

  config = lib.mkIf (cfg.xsv.enable && cfg.gui.enable) {
    home-manager = lib.install (with pkgs; [
      arandr
      xorg.xrandr
    ]);

    console.useXkbConfig = true;

    services.xserver = {
      xkb.layout = "us";
      xkb.variant =
        if config.cyanea.keyboards.dvorak.enable
        then "dvorak"
        else "";
      enable = true;
      #videoDrivers = [ "nvidia" ];
    };
  };
}
