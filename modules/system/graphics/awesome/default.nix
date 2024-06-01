{
  config,
  lib,
  user,
  inputs,
  ...
}: let
  awesome_path = "${config.cyanea.user.dotfilesPath}/config/awesome";
	cfg = config.cyanea.graphical;
in {
  options = {
    cyanea.graphical.awesome.enable = lib.mkEnableOption "enable awesome_config";
  };

  config = lib.mkIf (cfg.awesome.enable && cfg.gui.enable) {
    environment.systemPackages = [
      inputs.lua-pam.packages."x86_64-linux".default
    ];

    home-manager.users."${user.name}" = {config, ...}: {
      home.file."${awesome_path}/themes/default/colors.lua".text = ''
        local colors = {}
        return colors
      '';
      xdg.configFile = {
        "awesome/".source = config.lib.file.mkOutOfStoreSymlink awesome_path;
      };
    };
  };
}
