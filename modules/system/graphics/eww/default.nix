{
  config,
  lib,
  user,
  pkgs,
  ...
}: let
  eww_path = "${config.cyanea.user.dotfilesPath}/config/eww";
in {
  options.cyanea.graphical.eww.enable = lib.mkEnableOption "Enable Eww";

  config = lib.mkIf config.cyanea.graphical.eww.enable {
    environment.systemPackages = with pkgs; [
      eww
    ];
    home-manager.users."${user.name}" = {config, ...}: {
      # programs.eww = {
      #   enable = true;
      #   configDir = dotfilesPath + /config/eww;
      # };
      xdg.configFile = {
        "eww/".source = config.lib.file.mkOutOfStoreSymlink eww_path;
      };
    };
  };
}
