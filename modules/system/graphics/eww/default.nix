{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  options.cyanea.graphical.eww.enable = lib.mkEnableOption "Enable Eww";

  config = lib.mkIf config.cyanea.graphical.eww.enable {
    home-manager.users."${lib.user.name}" = {
      home.packages = with pkgs; [
        eww
        inputs.dotfiles.packages.${pkgs.system}.default
      ];

      xdg.configFile = {
        "eww/".source = "${config.cyanea.dotfilesPath}/share/eww";
      };
    };
  };
}
