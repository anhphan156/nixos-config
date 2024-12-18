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
      # programs.eww = {
      #   enable = true;
      #   configDir = dotfilesPath + /config/eww;
      # };

      home.packages = with pkgs; [
        eww
      ];

      xdg.configFile = {
        "eww/".source = inputs.eww-config.packages.${pkgs.system}.default;
      };
    };
  };
}
