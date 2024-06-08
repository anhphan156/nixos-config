{lib, ...}:
with lib; {
  cyanea = {
    desktopApp = {
      vesktop = enabled;
      firefox = enabled;
      keepassxc = enabled;
      rofi = enabled;
    };
    system = {
      hostname = "backlight";
      acpid = enabled;
      autorandr = enabled;
      laptop = enabled;
      light_control = enabled;
      xremap = enabled;
    };
    graphical = {
      gui = enabled;
      awesome = enabled;
    };
    services = {
      water_reminder = enabled;
    };
    terminal = {
      tmux = enabled;
    };
    music = enabled;
  };

  fileSystems."/persistence".neededForBoot = true;
  environment.persistence."/persistence" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
      {
        directory = "/var/lib/colord";
        user = "colord";
        group = "colord";
        mode = "u=rwx,g=rx,o=";
      }
    ];
    files = [
      "/etc/machine-id"
    ];
    users."${user.name}" = {
      directories = [
        "dotfiles"
        {
          directory = ".ssh";
          mode = "0700";
        }
      ];
    };
  };

  system.stateVersion = "23.11";
}
