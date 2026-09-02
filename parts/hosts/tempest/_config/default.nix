{ config, lib, ... }: {
  imports = [
    ./disk.nix
    ./hardware.nix
  ];

  config = {
    niri = {
      outputs = {
        "eDP-1" = {
          mode = "1920x1080";
          scale = 1.0;
          background-color = "#333333";
          position = {
            _attrs = {
              x = 0;
              y = 0;
            };
          };
          hot-corners = {
            off = null;
          };
        };
      };
    };

    services.udev.extraRules = ''
      SUBSYSTEM=="backlight", ACTION=="add", KERNEL=="intel_backlight", ATTR{brightness}="2400"
    '';

    users.users."${config.username}" = {
      extraGroups = lib.mkAfter [ "video" ];
    };

    system.stateVersion = "26.05";
  };
}
