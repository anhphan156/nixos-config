{
  user,
  pkgs,
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.cyanea.graphical.gui.enable {
    home-manager.users."${user.name}" = {
      qt.enable = true;
      qt.platformTheme.name = "gtk";
      qt.style.name = "adwaita-dark";
      qt.style.package = pkgs.adwaita-qt;
    };
  };
}
