{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: let
  awesome_path = "${pkgs.myDotfiles}/share/awesome";
  cfg = config.cyanea.graphical;
in {
  options = {
    cyanea.graphical.awesome.enable = lib.mkEnableOption "enable awesome_config";
  };

  config = lib.mkIf (cfg.awesome.enable && cfg.gui.enable) {
    cyanea.graphical.xsv = lib.enabled;
    cyanea.graphical.picom = lib.enabled;
    cyanea.desktopApp.rofi = lib.enabled;

    environment.systemPackages = [
      inputs.lua-pam.packages."x86_64-linux".default
      (pkgs.callPackage (inputs.src + /packages/user_scripts/rofi/awesome_layout.nix) {})
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

    home-manager.users."${lib.user.name}" = {config, ...}: {
      xdg.configFile = {
        "awesome/".source = config.lib.file.mkOutOfStoreSymlink awesome_path;
      };
    };
  };
}
