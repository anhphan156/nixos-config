{
  config,
  lib,
  user,
  ...
}: {
  options.cyanea.graphical.mako.enable = lib.mkEnableOption "Enable Mako";
  config = lib.mkIf config.cyanea.graphical.mako.enable {
    home-manager.users.${user.name} = {config, ...}: {
      services.mako = {
        enable = true;
        anchor = "top-right";
        borderRadius = 12;
        borderSize = 2;
        borderColor = "#ce3454aa";
        backgroundColor = "#222222ff";
        progressColor = "over #ce3454aa";
        font = "AnkaCoder 10";
        iconPath = "${config.home.homeDirectory}/dotfiles/config/awesome/themes/default/icons/";
      };
    };
  };
}
