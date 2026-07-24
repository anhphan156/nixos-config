{
  config,
  lib,
  ...
}: {
  options.cyanea.desktopApp.librewolf.enable = lib.mkEnableOption "Enable librewolf";
  config = lib.mkIf config.cyanea.desktopApp.librewolf.enable {
    home-manager.users.${lib.user.name}.programs.librewolf = {
      enable = true;
      settings = {
        "webgl.disabled" = false;
        "privacy.resistFingerprinting" = false;
        "privacy.clearOnShutdown.history" = false;
        "privacy.clearOnShutdown.cookies" = false;
        "network.cookie.lifetimePolicy" = 0;
      };
    };
  };
}
