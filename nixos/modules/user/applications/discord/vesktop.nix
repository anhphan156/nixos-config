{
  lib,
  config,
  user,
  pkgs,
  ...
}: {
  options = {
    vesktop.enable = lib.mkEnableOption "Enable Vesktop";
  };

  config = lib.mkIf (config.vesktop.enable && config.gui.enable) {
    home-manager.users."${user.name}".home.packages = with pkgs; [
      vesktop
    ];
  };
}
