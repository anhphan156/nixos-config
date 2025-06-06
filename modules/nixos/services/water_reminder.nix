{
  pkgs,
  config,
  lib,
  ...
}: {
  options.cyanea.services.waterReminder.enable = lib.mkEnableOption "Enable water reminder timer";

  config = lib.mkIf config.cyanea.services.waterReminder.enable {
    systemd.timers."water-reminder" = {
      wantedBy = ["timers.target"];
      timerConfig = {
        OnBootSec = "30m";
        OnUnitActiveSec = "30min";
        Unit = "water-reminder.service";
      };
    };
    systemd.services."water-reminder" = {
      script = ''
        ${lib.getExe pkgs.libnotify} "Reminder" "Drink yo watah" -t 30000 --icon="${pkgs.wallpapers}/icons/rain.png"
      '';
      serviceConfig = {
        Type = "oneshot";
        User = "${lib.user.name}";
        Environment = "DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus";
      };
    };
  };
}
