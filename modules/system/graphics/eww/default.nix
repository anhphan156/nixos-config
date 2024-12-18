{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  options.cyanea.graphical.eww.enable = lib.mkEnableOption "Enable Eww";

  config = lib.mkIf config.cyanea.graphical.eww.enable {
    home-manager.users."${lib.user.name}" = let
      eww-config = inputs.eww-config.packages.${pkgs.system}.default;
    in {
      # programs.eww = {
      #   enable = true;
      #   configDir = dotfilesPath + /config/eww;
      # };

      home.packages = with pkgs; [
        eww
        eww-config
      ];

      xdg.configFile = {
        "eww/".source = "${eww-config}/share/eww-config";
      };
    };
  };
}
