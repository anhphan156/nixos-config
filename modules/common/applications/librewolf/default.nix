{
  config,
  lib,
  inputs,
  ...
}: {
  options.cyanea.desktopApp.librewolf.enable = lib.mkEnableOption "Enable librewolf";
  config = lib.mkIf config.cyanea.desktopApp.librewolf.enable {
    home-manager.users.${lib.user.name} = import "${inputs.self}/modules/home-manager/applications/librewolf";
  };
}
