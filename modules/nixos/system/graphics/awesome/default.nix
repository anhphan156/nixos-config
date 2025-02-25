{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: let
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
      inputs.lua-pam.packages.${pkgs.system}.default
      (pkgs.callPackage (inputs.self + /packages/scripts/rofi/awesome_layout.nix) {
        rofiConfig = config.dotfiles.rofi.default;
      })
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

    home-manager.users."${lib.user.name}" = import "${inputs.self}/modules/home-manager/dotfiles/awesomewm";
  };
}
