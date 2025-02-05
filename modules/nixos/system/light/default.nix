{
  config,
  lib,
  pkgs,
  ...
}: {
  options.cyanea.system.lightControl.enable = lib.mkEnableOption "Enable brightness control";
  config = lib.mkIf config.cyanea.system.lightControl.enable {
    programs.light.enable = true;
    environment.systemPackages = with pkgs; [
      brightnessctl
      acpilight
    ];
    users.users."${lib.user.name}" = {
      extraGroups = lib.mkAfter ["video"];
    };
  };
}
