{
  config,
  pkgs,
  lib,
  user,
  inputs,
  ...
}: 
let
	awesome_path = "${config.dotfilesPath}/config/awesome";
in {
  options = {
    awesome.enable = lib.mkEnableOption "enable awesome_config";
  };

  config = lib.mkIf (config.awesome.enable && config.gui.enable) {
    environment.systemPackages = with pkgs; [
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
