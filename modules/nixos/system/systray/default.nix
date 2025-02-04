{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.cyanea.graphical.gui.enable {
    home-manager.users."${lib.user.name}" = {
      systemd.user.targets.tray = {
        Unit = {
          Description = "Home Manager System Tray";
          Requires = ["graphical-session-pre.target"];
        };
      };

      services.pasystray.enable = true;
      services.network-manager-applet.enable = true;
    };
  };
}
