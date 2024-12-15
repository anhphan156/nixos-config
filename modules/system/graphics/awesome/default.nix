{
  config,
  lib,
  user,
  inputs,
  pkgs,
  ...
}: let
  awesome_path = "${config.cyanea.dotfilesPath}/config/awesome";
  cfg = config.cyanea.graphical;
in {
  options = {
    cyanea.graphical.awesome.enable = lib.mkEnableOption "enable awesome_config";
  };

  config = lib.mkIf (cfg.awesome.enable && cfg.gui.enable) {
    cyanea.graphical.xsv = lib.enabled;
    cyanea.graphical.picom = lib.enabled;

    environment.systemPackages = [
      inputs.lua-pam.packages."x86_64-linux".default
      (pkgs.callPackage (user.path.root + /packages/user_scripts/rofi/awesome_layout.nix) {})
      pkgs.xclip
      pkgs.maim
      pkgs.xdotool
    ];

    services.xserver = {
      windowManager.awesome = lib.mkIf cfg.awesome.enable {
        enable = true;
        package = pkgs.awesome;
        luaModules = with pkgs.luaPackages; [
          luarocks
          luadbi-mysql
        ];
      };
    };

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
