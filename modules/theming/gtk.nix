{
  pkgs,
  user,
  lib,
  config,
  inputs,
  ...
}: {
  config = lib.mkIf config.cyanea.graphical.gui.enable {
    #  home-manager.users."${user.name}" = lib.mkIf (config.cyanea.theme == "amarena") {
    # imports = [
    # 	inputs.catppuccin.homeManagerModules.catppuccin
    # ];
    # catppuccin = {
    # 	enable = false;
    # 	flavor = "macchiato";
    # };
    #
    #    gtk.enable = true;
    #    gtk.theme.package = pkgs.amarena-theme;
    #    gtk.theme.name = "amarena";
    #    gtk.iconTheme.package = pkgs.tokyonight-gtk-theme;
    #    gtk.iconTheme.name = "Tela-circle-Dark";
    #  };
    home-manager.users."${user.name}" = lib.mkIf (config.cyanea.theme == "tokyonight") {
      gtk.enable = true;

      gtk.theme.package = pkgs.tokyonight-gtk-theme;
      gtk.theme.name = "Tokyonight-Dark";

      gtk.iconTheme.package = pkgs.paper-icon-theme;
      gtk.iconTheme.name = "Paper";
    };
  };
}
