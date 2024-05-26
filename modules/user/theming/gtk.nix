{
  pkgs,
  user,
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.gui.enable {
    home-manager.users."${user.name}" = {
      gtk.enable = true;

      gtk.theme.package = pkgs.tokyonight-gtk-theme;
      gtk.theme.name = "Tokyonight-Dark-BL-LB";

      gtk.iconTheme.package = pkgs.tokyonight-gtk-theme;
      gtk.iconTheme.name = "Tokyonight-Dark";
    };
  };
}
