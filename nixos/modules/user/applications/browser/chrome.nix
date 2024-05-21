{
  lib,
  config,
  user,
  pkgs,
  ...
}: {
  options = {
    googlechrome.enable = lib.mkEnableOption "Enable Google Chrome";
  };

  config = lib.mkIf (config.gui.enable && config.googlechrome.enable) {
    home-manager.users."${user.name}".home.packages = with pkgs; [
      google-chrome
    ];
  };
}
