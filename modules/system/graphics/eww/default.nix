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
        inputs.dotfiles.packages.${pkgs.system}.eww-scripts
      ];

      xdg.configFile = {
        "eww/".source = "${pkgs.myDotfiles}/share/eww";
      };
    };
  };
}
