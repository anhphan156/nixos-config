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
      qt.platformTheme.name = "kvantum";
      qt.style.name = "kvantum";
      qt.style.package = pkgs.adwaita-qt;
    };
  };
}
